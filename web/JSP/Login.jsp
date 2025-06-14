<%--
  Created by IntelliJ IDEA.
  User: Kalana Warnakulasooriya
  Date: 6/13/2025
  Time: 12:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="../CSS/Login.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Login - CMS</title>
</head>
<body>
    <div class="login-container">
        <h2>Login to Your Account</h2>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <i class="fas fa-user-circle"></i>
                <input type="text" id="username" name="username" required placeholder="Enter your username">
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>

            <div class="remember-group">
                <input type="checkbox" id="remember-me" name="rememberMe">
                <label for="remember-me">Remember Me</label>
            </div>

            <button id="btn-login" type="submit">Login</button>

            <p>Don't have an account? <a href="${pageContext.request.contextPath}/jsp/singup.jsp">Register here</a></p>
        </form>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Login Failed',
            text: '<%= error %>',
            confirmButtonColor: '#d33'
        });
    </script>
    <%
        }
    %>

    <% String signupStatus = request.getParameter("signup"); %>
    <script>
        <% if ("success".equals(signupStatus)) { %>
        Swal.fire("Account Created!", "You can now log in.", "success");
        <% } %>
    </script>
</body>
</html>
