package lk.ijse.cms.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.cms.dao.UserDAO;
import lk.ijse.cms.util.UserEncryption;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet("/register")
public class Register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String password2 = req.getParameter("password2");
        String role = req.getParameter("role"); // ✅ Get selected role from form

        if (username == null || username.isEmpty()) {
            req.setAttribute("errorMessage", "Username is required.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(password2)) {
            req.setAttribute("errorMessage", "Passwords do not match.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        ServletContext sc = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) sc.getAttribute("ds");

        try {
            String encryptedPassword = UserEncryption.encrypt(password);
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

            if (UserDAO.addUser(getServletContext(), sql, username, encryptedPassword, role)) {
                // ✅ Pass selected role to DB insert
                req.setAttribute("successMessage", "User registered successfully.");
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            } else {
                req.setAttribute("errorMessage", "Failed to register user.");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}
