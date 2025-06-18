package lk.ijse.cms.controller;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.cms.dao.ComplainDAO;
import lk.ijse.cms.model.Complain;
import lk.ijse.cms.util.JWTUtil;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/addComplaint")
public class AddComplaint extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext context = getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");

        HttpSession session = req.getSession();
        String created_by = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");

        String description = req.getParameter("description");
        String remark = req.getParameter("remark");
        String subject = req.getParameter("subject");
        String status = req.getParameter("status") == null ? "PENDING" : req.getParameter("status");
        String incidentDate = req.getParameter("incidentDate");
        String complainID = req.getParameter("complainID");

        if (complainID != null && !complainID.isEmpty()) {
            System.out.println("Updating complaint ID: " + complainID);
            try {
                Connection connection = dataSource.getConnection();
                String sql;
                int rowsAffected;
                if (role.equals("EMPLOYEE")) {
                    sql = "UPDATE complaints SET title = ?, description = ?, created_at = ?, status = ? WHERE id = ?";
                    rowsAffected = ComplainDAO.updateAddDeleteComplaint(
                            getServletContext(),
                            sql,
                            subject,
                            description,
                            incidentDate,
                            status,
                            Integer.parseInt(complainID)
                    );
                } else{
                    sql = "UPDATE complaints SET status = ?, remarks = ? WHERE id = ?";
                    rowsAffected = ComplainDAO.updateAddDeleteComplaint(
                            getServletContext(),
                            sql,
                            status,
                            remark,
                            Integer.parseInt(complainID)
                    );
                }
                connection.close();
                if (rowsAffected > 0) {
                    System.out.println("Complaint updated successfully.");
                    String message = "Complaint updated successfully.";
                    if (role.equals("EMPLOYEE")) {
                        message = "Complaint updated successfully. Please wait for admin approval.";
                    }
                    req.getSession().setAttribute("message", message);
                } else {
                    req.getSession().setAttribute("message", "Complaint updated unsuccessfully");
                }
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            try {
                String sql = "INSERT INTO complaints (title, description, status, created_at, user_id) VALUES (?, ?, ?, ?, ?)";
                int rowsAffected = ComplainDAO.updateAddDeleteComplaint(getServletContext(),
                        sql,
                        subject,
                        description,
                        status,
                        incidentDate,
                        created_by
                );
                if (rowsAffected > 0) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard");
                } else {
                    resp.getWriter().println("Failed to add complaint.");
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complainID = req.getParameter("complainID");
        Cookie[] cookies = req.getCookies();
        DecodedJWT decodedJWT = JWTUtil.decodeToken(cookies);

        if (decodedJWT == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in to access this page.");
            return;
        }

        if (complainID == null || complainID.isEmpty()) {
            System.out.println("No Complain ID provided, forwarding to addComplaint.jsp");
            if(decodedJWT.getClaim("role").asString().equals("ADMIN")) {
                req.getRequestDispatcher("/admin/addComplaint.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/user/addComplaint.jsp").forward(req, resp);
            }
            return;
        }

        ServletContext context = getServletContext();
        String findByID = "SELECT * FROM complaints WHERE id = ?";
        try {
            Complain complain = ComplainDAO.findByID(getServletContext(), findByID, Integer.parseInt(complainID));
            if (complain == null) {
                resp.getWriter().println("Complaint not found.");
                return;
            }

            String jwtUserId = decodedJWT.getSubject();
            String jwtRole = decodedJWT.getClaim("role").asString();

            if (!jwtUserId.equals(complain.getUser_id()) && !"ADMIN".equals(jwtRole)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not authorized to view this complaint.");
                return;
            }

            req.setAttribute("complain", complain);
            if ("ADMIN".equals(jwtRole)) {
                req.getRequestDispatcher("/admin/editComplaint.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/user/addComplaint.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
