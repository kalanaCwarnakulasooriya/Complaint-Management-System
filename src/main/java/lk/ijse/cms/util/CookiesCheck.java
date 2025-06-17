package lk.ijse.cms.util;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class CookiesCheck implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI();
        //System.out.println("Request URI: " + path);

        if (path.endsWith("login.jsp") || path.endsWith("register.jsp") ||
                path.endsWith("/Login") || path.endsWith("/Register") ||  // ✅ this line is critical
                path.endsWith("/login") || path.endsWith("/register") ||  // ✅ for lowercase servlet paths
                path.contains("/css") || path.contains("/js") || path.contains("/images")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("role");
        String userId = (String) session.getAttribute("user");
        if (role != null && userId != null) {
            // Valid session, proceed with the request
            System.out.println("Valid session found. User ID: " + userId + ", Role: " + role);
            chain.doFilter(request, response);
            return;
        }
        System.out.println("No valid session. Redirecting to login.");
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
