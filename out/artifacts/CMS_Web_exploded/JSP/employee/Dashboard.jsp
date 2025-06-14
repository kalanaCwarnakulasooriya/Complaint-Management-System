<%--
  Created by IntelliJ IDEA.
  User: VivoBook
  Date: 6/14/2025
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.Model.Complaint" %>

<%
  List<Complaint> complaintList = (List<Complaint>) request.getAttribute("complaintList");
  String success = request.getParameter("message");
  String error = request.getParameter("error");
%>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="../CSS/EmpDashboard.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <title>Submit Complaint</title>
</head>
<body>

<!-- 🔝 Top Navigation Bar -->
<div class="navbar">
  <a href="${pageContext.request.contextPath}/jsp/employee/dashboard.jsp">My Complaints</a>
  <a href="${pageContext.request.contextPath}/jsp/login.jsp">Logout</a>
</div>

<!-- ✅ SweetAlert Popups -->
<% if (success != null) { %>
<script>
  Swal.fire({
    icon: 'success',
    title: 'Success',
    text: '<%= success %>',
    confirmButtonColor: '#3085d6'
  });
</script>
<% } else if (error != null) { %>
<script>
  Swal.fire({
    icon: 'error',
    title: 'Error',
    text: '<%= error %>',
    confirmButtonColor: '#d33'
  });
</script>
<% } %>

<!-- 📝 Complaint Form Section -->
<div class="container">
  <div class="form-box">
    <div class="form-title">Submit Complaint</div>
    <form action="${pageContext.request.contextPath}/submit-complaint" method="post">
      <input type="hidden" name="user_id" value="${sessionScope.user_id}" />

      <label>Title:</label>
      <input type="text" name="title" required />

      <label>Description:</label>
      <textarea name="description" rows="5" required></textarea>

      <!-- Buttons -->
      <input type="submit" value="Submit" class="btn-submit" />
      <button type="button" class="btn-clear" onclick="clearForm()">Clear</button>
      <button type="submit" formaction="update-complaint" class="btn-update">Update</button>
      <button type="submit" formaction="delete-complaint" class="btn-delete"
              onclick="return confirm('Are you sure you want to delete this complaint?')">Delete</button>
    </form>
  </div>

  <!-- 📋 Complaints Table -->
  <table class="complaints-table">
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Description</th>
      <th>Status</th>
      <th>Remarks</th>
      <th>Created At</th>
    </tr>
    <%
      if (complaintList == null || complaintList.isEmpty()) {
    %>
    <tr><td colspan="6">No complaints found.</td></tr>
    <%
    } else {
      for (Complaint c : complaintList) {
    %>
    <tr>
      <td><%= c.getComplaintId() %></td>
      <td><%= c.getTitle() %></td>
      <td><%= c.getDescription() %></td>
      <td><%= c.getStatus() %></td>
      <td><%= c.getRemarks() %></td>
      <td><%= c.getCreatedAt() %></td>
    </tr>
    <%
        }
      }
    %>
  </table>
</div>

<!-- 🧠 JavaScript to clear form -->
<script>
  function clearForm() {
    document.querySelector('input[name="title"]').value = '';
    document.querySelector('textarea[name="description"]').value = '';
  }
</script>

</body>
</html>
