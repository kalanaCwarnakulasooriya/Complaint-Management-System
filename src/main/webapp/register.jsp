<%--
  Created by IntelliJ IDEA.
  User: Kalana Warnakulasooriya
  Date: 6/17/2025
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Complaint Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/register.css">
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<div class="register-container">
    <!-- Left Side - Branding -->
    <div class="register-left">
        <div class="register-left-content">
<%--            <i class="bi bi-person-plus display-1 mb-3"></i>--%>
            <h1>Join Us Today!</h1>
            <p>Create your account to start managing complaints efficiently</p>
        </div>
    </div>

    <!-- Right Side - Register Form -->
    <div class="register-right">
        <div class="register-header">
            <h2>Create Account</h2>
            <p>Fill in your details to get started</p>
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

        <!-- Register Form -->
        <form method="post" action="register">
            <div class="form-floating position-relative">
                <i class="bi bi-person input-icon"></i>
                <input type="text" class="form-control with-icon" id="username" name="username"
                       placeholder="Username" required autocomplete="username"
                       pattern="[a-zA-Z0-9_]{3,20}"
                       title="Username must be 3-20 characters long and contain only letters, numbers, and underscores">
                <label for="username" class="with-icon">Username</label>
            </div>

            <div class="form-floating position-relative">
                <i class="bi bi-lock input-icon"></i>
                <input type="password" class="form-control with-icon" id="password" name="password"
                       placeholder="Password" required autocomplete="new-password"
                       minlength="8"
                       title="Password must be at least 8 characters long">
                <label for="password" class="with-icon">Password</label>
            </div>

            <div class="form-floating position-relative">
                <i class="bi bi-lock-fill input-icon"></i>
                <input type="password" class="form-control with-icon" id="password2" name="password2"
                       placeholder="Confirm Password" required autocomplete="new-password"
                       minlength="8"
                       title="Please confirm your password">
                <label for="password2" class="with-icon">Confirm Password</label>
            </div>

            <button type="submit" class="btn btn-register">
<%--                <i class="bi bi-person-plus me-2"></i>--%>
                Create Account
            </button>

            <div class="login-link">
                <span class="text-muted">Already have an account? </span>
                <a href="login.jsp">
                    <i class="bi bi-box-arrow-in-right me-1"></i>
                    Sign In Here
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
