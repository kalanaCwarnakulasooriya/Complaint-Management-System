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

        if (username == null || username.isEmpty()) {
            resp.getWriter().println("Username is required.");
            return;
        }

        if (!password.equals(password2)){
            resp.getWriter().println("Passwords do not match.");
            return;
        }

        ServletContext sc = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) sc.getAttribute("ds");

        try {
            String encryptedPassword = UserEncryption.encrypt(password);
            String sql = "INSERT INTO users (username, password,role) VALUES (?, ?, ?)";

            if (UserDAO.addUser(getServletContext(), sql, username, encryptedPassword, "EMPLOYEE")) {
                // Registration successful
                resp.setContentType("text/html");
                resp.setStatus(HttpServletResponse.SC_OK);
//                resp.getWriter().println("User registered successfully.");
                resp.sendRedirect(req.getContextPath() + "/login.jsp");getServletContext();
            } else {
                resp.getWriter().println("Failed to register user.");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
