<%--
  Created by IntelliJ IDEA.
  User: VivoBook
  Date: 6/17/2025
  Time: 12:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CMS</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<div class="login-container">
    <!-- Left Side - Branding -->
    <div class="login-left">
        <div class="login-left-content">
<%--            <i class="bi bi-clipboard-check display-1 mb-3"></i>--%>
            <h1>Welcome Back!</h1>
            <p>Access your complaint management dashboard</p>
        </div>
    </div>

    <!-- Right Side - Login Form -->
    <div class="login-right">
        <div class="login-header">
            <h2>Sign In</h2>
            <p>Enter your credentials to access your account</p>
        </div>

        <!-- Error/Success Messages -->
        <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
        <div class="alert alert-danger alert-custom" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <%= errorMessage %>
        </div>
        <% } %>

        <% if (successMessage != null && !successMessage.trim().isEmpty()) { %>
        <div class="alert alert-success alert-custom" role="alert">
            <i class="bi bi-check-circle me-2"></i>
            <%= successMessage %>
        </div>
        <% } %>

        <!-- Login Form -->
        <form method="post" action="login">
            <div class="form-floating position-relative">
                <i class="bi bi-person input-icon"></i>
                <input type="text" class="form-control with-icon" id="username" name="username"
                       placeholder="Username" required autocomplete="username">
                <label for="username" class="with-icon">Username</label>
            </div>

            <div class="form-floating position-relative">
                <i class="bi bi-lock input-icon"></i>
                <input type="password" class="form-control with-icon" id="password" name="password"
                       placeholder="Password" required autocomplete="current-password">
                <label for="password" class="with-icon">Password</label>
            </div>

            <button type="submit" class="btn btn-login">
<%--                <i class="bi bi-box-arrow-in-right me-2"></i>--%>
                Sign In
            </button>

            <div class="register-user">
                <span class="text-muted">Already have an account? </span>
                <a href="register.jsp">
                    <i class="bi bi-pencil-square me-2"></i>
                    Register here
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
