<%--
  Created by IntelliJ IDEA.
  User: Kalana Warnakulasooriya
  Date: 6/13/2025
  Time: 12:12 AM
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
    <link rel="stylesheet" href="../CSS/Signup.css">
    <title>SignUp - CMS</title>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <h2>Create Your Account</h2>
            <p>Join our Complaint Management System to submit and track complaints efficiently</p>
        </div>

        <div class="signup-form">
            <form id="signupForm" action="${pageContext.request.contextPath}/signup" method="post" onsubmit="return validateSignupForm();">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <i class="fas fa-user"></i>
                        <input type="text" id="firstName" name="firstName" required placeholder="Enter your first name">
                    </div>

                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <i class="fas fa-user"></i>
                        <input type="text" id="lastName" name="lastName" required placeholder="Enter your last name">
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <i class="fas fa-map-marker-alt"></i>
                    <input type="text" id="address" name="address" required placeholder="Enter your address">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="mobile">Mobile Number</label>
                        <i class="fas fa-phone"></i>
                        <input type="tel" id="mobile" name="mobile" required placeholder="Enter your mobile number">
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" required placeholder="Enter your email">
                    </div>
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <i class="fas fa-user-circle"></i>
                    <input type="text" id="username" name="username" required placeholder="Choose a username">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" id="password" name="password" required placeholder="Create a password">
                        <div class="password-container">
                            <span class="toggle-password" onclick="togglePassword()">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm your password">
                        <div class="password-container">
                            <span class="toggle-password" onclick="toggleConfirmPassword()">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="department">Department</label>
                        <i class="fas fa-building"></i>
                        <select id="department" name="department" required>
                            <option value="" disabled selected>Select your department</option>
                            <option value="finance">Finance Department</option>
                            <option value="hr">Human Resources</option>
                            <option value="it">Information Technology</option>
                            <option value="operations">Operations</option>
                            <option value="customer">Customer Service</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="jobRole">Job Role</label>
                        <i class="fas fa-briefcase"></i>
                        <select id="jobRole" name="jobRole" required>
                            <option value="" disabled selected>Select your job role</option>
                            <option value="admin">Admin</option>
                            <option value="employee">Employee</option>
                        </select>
                    </div>
                </div>

                <div class="terms">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                </div>

                <button id="btn-signup" type="submit">Create Account</button>

                <%
                    String signupError = request.getParameter("signup-msg");
                    if (signupError != null && !signupError.isEmpty()) {

                        String icon = "error"; // default

                        if (signupError.toLowerCase().contains("account created")) {
                            icon = "success";
                        } else if (signupError.toLowerCase().contains("could not create user")) {
                            icon = "error";
                        }
                %>
                <script>
                    Swal.fire({
                        position: "center",
                        icon: "<%= icon %>",
                        title: "<%= signupError.replace("+", " ") %>",
                        showConfirmButton: true
                    });
                </script>
                <%
                    }
                %>

                <div class="error" id="error-message">
                    Passwords do not match. Please try again.
                </div>

                <div class="login-link">
                    Already have an account? <a href="login.jsp">Log in</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
