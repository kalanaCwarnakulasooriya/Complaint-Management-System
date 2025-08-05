package lk.ijse.cms.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.cms.dao.ComplainDAO;
import lk.ijse.cms.model.Complain;
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

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null || session.getAttribute("role") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String userId = (String) session.getAttribute("user");
        String role = (String) session.getAttribute("role");
        String subject = req.getParameter("subject");
        String description = req.getParameter("description");
        String remark = req.getParameter("remark");
        String status = req.getParameter("status") == null ? "PENDING" : req.getParameter("status").trim();
        String incidentDate = req.getParameter("incidentDate");
        String complainID = req.getParameter("complainID");

        try {
            int rowsAffected = 0;
            if (complainID != null && !complainID.isEmpty()) {
                if (role.equals("EMPLOYEE")) {
                    rowsAffected = ComplainDAO.updateAddDeleteComplaint(context,
                            "UPDATE complaints SET title=?, description=?, created_at=? WHERE id=?",
                            subject, description, incidentDate, Integer.parseInt(complainID));
                } else {
                    rowsAffected = ComplainDAO.updateAddDeleteComplaint(context,
                            "UPDATE complaints SET status=?, remarks=? WHERE id=?",
                            status, remark, Integer.parseInt(complainID));
                    System.out.println("Status value: " + status);
                }
            } else {
                rowsAffected = ComplainDAO.updateAddDeleteComplaint(context,
                        "INSERT INTO complaints (title, description, status, created_at, user_id) VALUES (?, ?, ?, ?, ?)",
                        subject, description, status, incidentDate, userId);
            }

            if (rowsAffected > 0) {
                session.setAttribute("message", "Complaint processed successfully");
            } else {
                session.setAttribute("message", "Failed to process complaint");
            }
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null || session.getAttribute("role") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String complainID = req.getParameter("complainID");

        if (complainID == null || complainID.isEmpty()) {
            req.getRequestDispatcher(role.equals("ADMIN") ? "/admin/addComplaint.jsp" : "/user/addComplaint.jsp").forward(req, resp);
            return;
        }

        try {
            Complain complain = ComplainDAO.findByID(getServletContext(), "SELECT * FROM complaints WHERE id = ?", Integer.parseInt(complainID));
            if (complain == null) {
                resp.getWriter().println("Complaint not found.");
                return;
            }
            req.setAttribute("complain", complain);
            req.getRequestDispatcher(role.equals("ADMIN") ? "/admin/editComplaint.jsp" : "/user/addComplaint.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
