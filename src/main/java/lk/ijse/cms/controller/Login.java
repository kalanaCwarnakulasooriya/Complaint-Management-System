package lk.ijse.cms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.cms.dao.UserDAO;
import lk.ijse.cms.model.User;
import lk.ijse.cms.util.UserEncryption;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String sql = "SELECT * FROM users WHERE username = ?";
            User user = UserDAO.findUserByUsername(getServletContext(), sql, username);

            if (user == null || !UserEncryption.decrypt(password, user.getPassword())) {
                // Invalid login
                req.setAttribute("errorMessage", "Invalid username or password.");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }

            // Valid login
            HttpSession session = req.getSession();
            session.setAttribute("user", user.getId());
            session.setAttribute("role", user.getRole());

            // Redirect by role
            resp.sendRedirect(req.getContextPath() + "/dashboard");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
