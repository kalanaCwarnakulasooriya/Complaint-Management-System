<%--
  Created by IntelliJ IDEA.
  User: Kalana Warnakulasooriya
  Date: 6/15/2025
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CMS</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
<%--    <link rel="stylesheet" href="css/register.css">--%>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
            --card-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }

        body {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
            color: #333;
        }

        .register-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
            display: flex;
            min-height: 550px;
        }

        .register-left {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            flex: 1;
            position: relative;
        }

        .register-left::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="2"/></svg>');
            background-size: 60px 60px;
            opacity: 0.3;
        }

        .register-left-content {
            position: relative;
            z-index: 2;
        }

        .register-left h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .register-left p {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .bi-person-plus {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .register-right {
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            flex: 1;
            background-color: white;
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .register-header p {
            color: #6c757d;
            margin: 0;
            font-size: 0.95rem;
        }

        .form-floating {
            margin-bottom: 1.25rem;
            position: relative;
        }

        .form-control {
            height: 50px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
            padding-left: 40px;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 5;
        }

        .form-control.with-icon {
            padding-left: 2.5rem; /* enough space for icon */
            position: relative;
            z-index: 1;
        }

        label.with-icon {
            padding-left: 2.5rem; /* aligns label with input text */
        }

        label.with-icon {
            padding-left: 35px;
        }

        .btn-register {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 12px;
            font-weight: 600;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 10px;
            color: white;
            letter-spacing: 0.5px;
        }

        .btn-register:hover {
            background: linear-gradient(to right, #233140, #2980b9);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(41, 128, 185, 0.3);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
        }

        .login-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }

        .login-link a:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }

        .alert-custom {
            border-radius: 8px;
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            border: none;
        }

        .alert-danger {
            background-color: #fdecea;
            color: #d32f2f;
        }

        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        .alert-custom i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        @media (max-width: 768px) {
            .register-container {
                flex-direction: column;
                max-width: 500px;
            }

            .register-left {
                padding: 2rem;
            }

            .register-right {
                padding: 2rem;
            }

            .register-left h1 {
                font-size: 1.8rem;
            }

            .register-header h2 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .register-container {
                border-radius: 10px;
            }

            .register-left, .register-right {
                padding: 1.5rem;
            }
        }

        /* Password strength indicator */
        .password-strength {
            height: 4px;
            background: #e0e0e0;
            border-radius: 2px;
            margin-top: 5px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            background: #e74c3c;
            transition: width 0.3s, background 0.3s;
        }
    </style>
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

            <!-- ✅ Role combo box -->
            <div class="form-floating position-relative">
                <i class="bi bi-person-badge input-icon"></i>
                <select class="form-select with-icon" id="role" name="role" required>
                    <option value="" disabled selected>Select Role</option>
                    <option value="ADMIN">Admin</option>
                    <option value="EMPLOYEE">Employee</option>
                </select>
                <label for="role" class="with-icon">Role</label>
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
