package lk.ijse.cms.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.cms.model.Complain;
import lk.ijse.cms.dao.ComplainDAO;
import lk.ijse.cms.model.StatusCount;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet({"/dashboard", "/"})
public class Dashboard extends HttpServlet {
    public void deleteComplaint(String complainID, ServletContext context) throws SQLException {
        String sql = "DELETE FROM complaints WHERE id = ?";
        ComplainDAO.updateAddDeleteComplaint(context, sql, Integer.parseInt(complainID));
    }

    public StatusCount getComplaintStatusCount(List<Complain> complaintList) {
        int pendingCount = 0;
        int resolvedCount = 0;
        int inProgressCount = 0;
        int totalCount = complaintList.size();

        for (Complain complain : complaintList) {
            String status = complain.getStatus().toUpperCase().replace(" ", "_");
            switch (status) {
                case "PENDING": pendingCount++; break;
                case "RESOLVED": resolvedCount++; break;
                case "IN_PROGRESS": inProgressCount++; break;
            }
        }
        return new StatusCount(pendingCount, resolvedCount, inProgressCount, totalCount);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null || session.getAttribute("role") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String complainID = req.getParameter("complainID");
        String role = (String) session.getAttribute("role");
        String userID = (String) session.getAttribute("user");
        ServletContext context = getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");

        try {
            if (complainID != null && !complainID.isEmpty() && role.equals("ADMIN")) {
                deleteComplaint(complainID, context);
                req.setAttribute("message", "Complaint ID " + complainID + " deleted successfully.");
            } else if (complainID != null && !complainID.isEmpty() && role.equals("EMPLOYEE")) {
                deleteComplaint(complainID, context);
                req.setAttribute("message", "Complaint ID " + complainID + " deleted successfully.");
            }

            Connection connection = dataSource.getConnection();
            List<Complain> complaintList;
            if (role.equals("ADMIN")) {
                complaintList = ComplainDAO.getComplains(context, "SELECT * FROM complaints");
                req.setAttribute("complaintList", complaintList);
                req.setAttribute("statusCount", getComplaintStatusCount(complaintList));
                req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
            } else {
                complaintList = ComplainDAO.getComplains(context, "SELECT * FROM complaints WHERE user_id = ?", userID);
                req.setAttribute("complaintList", complaintList);
                req.setAttribute("statusCount", getComplaintStatusCount(complaintList));
                req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);
            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}