package lk.ijse.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.Dao.UserDAO;
import lk.ijse.Model.User;
import org.apache.commons.dbcp2.BasicDataSource;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.List;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String name = (firstName + " " + lastName).trim();

        String address = req.getParameter("address");
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String rawPassword = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String department = req.getParameter("department");
        String jobRole = req.getParameter("jobRole");

        if (!rawPassword.equals(confirmPassword)) {
            resp.sendRedirect(req.getContextPath() + "/web/JSP/Signup.jsp?signup-msg=Passwords+do+not+match");
            return;
        }

        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

        ServletContext context = req.getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("dbcpDataSource");

        UserDAO userDAO = new UserDAO(dataSource);

        try {
            User user = new User();
            user.setName(name);
            user.setAddress(address);
            user.setMobile(mobile);
            user.setEmail(email);
            user.setUsername(username);
            user.setPassword(hashedPassword);
            user.setDepartment(department);
            user.setJobRole(jobRole);

            if (userDAO.isUsernameTaken(username)) {
                resp.sendRedirect(req.getContextPath() + "/web/JSP/Signup.jsp?signup-msg=Username+already+taken");
                return;
            }

            if (userDAO.saveUser(user)) {
                resp.sendRedirect(req.getContextPath() + "/web/JSP/login.jsp?signup-msg=Account+created");
            } else {
                resp.sendRedirect(req.getContextPath() + "/web/JSP/Signup.jsp?signup-msg=Could+not+create+user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/web/JSP/Signup.jsp?signup-msg=Server+error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext context = getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("dbcpDataSource");
        UserDAO userDAO = new UserDAO(dataSource);

        List<String> usernames = userDAO.getAllUsernames();

        req.setAttribute("existingUsernames", usernames);
        req.getRequestDispatcher("/web/JSP/Signup.jsp").forward(req, resp);
    }
}
