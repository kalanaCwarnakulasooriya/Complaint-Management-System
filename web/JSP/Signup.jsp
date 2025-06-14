<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    List<String> usernames = (List<String>) request.getAttribute("existingUsernames");
    if (usernames == null) usernames = new ArrayList<>();
    String jsonUsernames = new Gson().toJson(usernames);
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
        <form id="signupForm" action="${pageContext.request.contextPath}/signup" method="post">
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
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" required placeholder="Create a password">
                    <div class="password-container">
                        <span class="toggle-password" onclick="togglePassword()">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <i class="fas fa-lock"></i>
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

            <div class="error" id="error-message" style="display:none;">
                Passwords do not match. Please try again.
            </div>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Log in</a>
            </div>
        </form>
    </div>
</div>

<input type="hidden" id="existingUsernames" value='<%= jsonUsernames %>'>

<script>
    <% if ("username_taken".equals(request.getParameter("Signup"))) { %>
    Swal.fire({
        icon: "Warning",
        title: "Username Taken!",
        text: "Please choose a different username."
    });
    <% } else if ("pass_mismatch".equals(request.getParameter("Signup"))) { %>
    Swal.fire({ icon: "error", title: "Password do not match!", text: "Please try again." });
    <% } else if ("fail".equals(request.getParameter("Signup"))) { %>
    Swal.fire({ icon: "error", title: "Oops!", text: "Something went wrong. Please try again." });
    <% } else if ("success".equals(request.getParameter("Signup"))) { %>
    Swal.fire({ icon: "success", title: "Account Created!", text: "You can now log in." });
    <% } %>
</script>

<script src="../JS/Signup.js"></script>
</body>
</html>
