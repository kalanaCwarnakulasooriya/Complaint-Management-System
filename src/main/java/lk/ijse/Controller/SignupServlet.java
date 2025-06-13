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

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Collect and combine names
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String name = (firstName + " " + lastName).trim();

        String address = req.getParameter("address");
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String rawPassword = req.getParameter("password"); // raw password from form
        String department = req.getParameter("department");
        String jobRole = req.getParameter("jobRole");

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

            if (userDAO.saveUser(user)) {
                resp.sendRedirect("web/JSP/login.jsp?signup-msg=Account+created");
            } else {
                resp.sendRedirect("web/JSP/Signup.jsp?signup-msg=Could+not+create+user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("JSP/Signup.jsp?signup-msg=Server+error");
        }
    }
}
