package lk.ijse.cms.controller;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.cms.model.Complain;
import lk.ijse.cms.dao.ComplainDAO;
import lk.ijse.cms.model.StatusCount;
import lk.ijse.cms.util.JWTUtil;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@WebServlet({"/dashboard", "/"})
public class Dashboard extends HttpServlet {
    public void deleteComplaint(String complainID) {
        ServletContext context = getServletContext();
        try {
            String sql = "DELETE FROM complaints WHERE id = ?";
            ComplainDAO.updateAddDeleteComplaint(getServletContext(), sql, Integer.parseInt(complainID));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public StatusCount getComplaintStatusCount(List<Complain> complaintList) {
        int pendingCount = 0;
        int resolvedCount = 0;
        int inProgressCount = 0;
        int totalCount = complaintList.size();

        for (Complain complain : complaintList) {
            switch (complain.getStatus()) {
                case "PENDING":
                    pendingCount++;
                    break;
                case "RESOLVED":
                    resolvedCount++;
                    break;
                case "IN_PROGRESS":
                    inProgressCount++;
                    break;
            }
        }
        return new StatusCount(pendingCount, resolvedCount, inProgressCount, totalCount);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        Cookie[] cookies = req.getCookies();
        ServletContext context = getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        String complainID = req.getParameter("complainID");

        if (complainID != null && !complainID.isEmpty()) {
            deleteComplaint(complainID);
            req.setAttribute("message", complainID + " Complaint Deleted Successfully");
        }
        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("role");
        String userID = (String) session.getAttribute("user");
        try {
            Connection connection = dataSource.getConnection();
            if (role.equals("ADMIN")) {

                String sql_complaint = "SELECT * FROM complaints";
                List<Complain> complaintList = ComplainDAO.getComplains(getServletContext(), sql_complaint);
                StatusCount statusCount = getComplaintStatusCount(complaintList);

                req.setAttribute("statusCount", statusCount);
                req.setAttribute("complaintList", complaintList);

                req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
            }else{
                String sql_complaint = "SELECT * FROM complaints WHERE user_id = ?";
                List<Complain> complaintList = ComplainDAO.getComplains(getServletContext(), sql_complaint, userID);
                StatusCount statusCount = getComplaintStatusCount(complaintList);
                req.setAttribute("statusCount", statusCount);
                req.setAttribute("complaintList", complaintList);
                connection.close();
                req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}