<%--
  Created by IntelliJ IDEA.
  User: Kalana Warnakulasooriya
  Date: 6/18/2025
  Time: 12:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.cms.model.Complain" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Submission Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
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
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-bg);
        }

        .navbar-custom {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
        }

        .navbar-brand .badge {
            font-size: 0.8rem;
            margin-left: 1rem;
        }

        .btn-back {
            padding: 0.4rem 0.8rem;
            font-size: 0.85rem;
            font-weight: 500;
            background-color: #ffffff;
            color: #2c3e50;
            border-radius: 0.5rem;
            transition: all 0.2s ease;
            border: none;
        }

        .btn-back:hover {
            background-color: #f1f1f1;
            transform: translateY(-1px);
        }

        .form-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            max-width: 800px;
            margin: 2rem auto;
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(to right, #141e30, #243b55);
            /*background: linear-gradient(to right, var(--primary-color), var(--secondary-color));*/
            color: #fff;
            padding: 2rem;
            text-align: center;
        }

        .form-header h1 {
            font-size: 1.8rem;
            font-weight: 600;
            margin: 0;
        }

        .form-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .form-control:hover, .form-select:hover {
            border-color: var(--secondary-color);
        }

        .form-footer {
            background-color: #f8f9fa;
            padding: 1rem 2rem;
            border-top: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
        }

        .required {
            color: var(--danger-color);
        }

        @media (max-width: 768px) {
            .form-header h1 { font-size: 1.5rem; }
            .form-footer { flex-direction: column; align-items: stretch; }
            .btn { width: 100%; }
        }
    </style>
</head>
<body>
<%
    Complain complaint = null;
    String pageTitle = "Submit a Complaint";
    String submitButtonText = "Submit Complaint";

    try {
        complaint = (Complain) request.getAttribute("complain");
        if (complaint != null && complaint.getId() > 0) {
            pageTitle = "Edit Complaint";
            submitButtonText = "Update Complaint";
        }
    } catch (Exception e) {
        System.out.println("Error: " + e.getMessage());
    }
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard">
            <%--            <i class="bi bi-clipboard-check me-2"></i>Complaint Management System--%>
            <span class="badge bg-light text-dark d-flex align-items-center ms-3">
        <i class="bi bi-person-badge-fill me-1"></i>Complaint Form - C M S
      </span>
        </a>
        <div class="ms-auto">
            <a href="dashboard" class="btn btn-back">
                <i class="bi bi-arrow-left-circle me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container-fluid py-4">
    <div class="form-container">
        <!-- Form Header -->
        <div class="form-header">
<%--            <i class="bi bi-clipboard-plus display-4 mb-3"></i>--%>
            <h1><%= pageTitle %></h1>
            <p>Please fill out all required fields to submit your complaint</p>
        </div>

        <!-- Form Body -->
        <form action="addComplaint" method="post" id="complaintForm">
            <div class="form-body">
                <!-- Hidden ID Field -->
                <input type="hidden" name="complainID" id="complainID"
                       value="<%= (complaint != null) ? complaint.getId() : "" %>">

                <!-- Basic Information Section -->
                <div class="form-section">
<%--                    <h5><i class="bi bi-info-circle form-icon"></i>Basic Information</h5>--%>
                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label for="subject" class="form-label">
                                <i class="bi bi-card-text me-1"></i>Subject <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="subject" name="subject"
                                   value="<%= (complaint != null && complaint.getTitle() != null) ? complaint.getTitle() : "" %>"
                                   placeholder="Enter a brief subject for your complaint">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">
                            <i class="bi bi-file-text me-1"></i>Description <span class="required">*</span>
                        </label>
                        <textarea class="form-control" id="description" name="description" rows="5"
                                  placeholder="Please provide a detailed description of your complaint..."
                                  maxlength="1000"><%= (complaint != null && complaint.getDescription() != null) ? complaint.getDescription() : "" %></textarea>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="incidentDate" class="form-label">
                            <i class="bi bi-calendar-event me-1"></i>Incident Date
                        </label>
                        <input type="date" class="form-control" id="incidentDate" name="incidentDate"
                               value="<%= (complaint != null && complaint.getCreated_at() != null) ? complaint.getCreated_at() : "" %>">
                    </div>
                    <!-- status change -->
                    <div class="col-md-6 mb-3">
                        <label for="status" class="form-label">
                            <i class="bi bi-check-circle me-1"></i>Status <span class="required">*</span>
                        </label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="">Select Status</option>
                            <option value="pending" <%= (complaint != null && "PENDING".equals(complaint.getStatus())) ? "selected" : "" %>>Pending</option>
                            <option value="in_progress" <%= (complaint != null && "IN_PROGRESS".equals(complaint.getStatus())) ? "selected" : "" %>>In Progress</option>
                            <option value="resolved" <%= (complaint != null && "RESOLVED".equals(complaint.getStatus())) ? "selected" : "" %>>Resolved</option>
                        </select>
                        <div id="statusBadge"></div>
                    </div>

                    <!-- add admin remark -->
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-chat-dots me-1"></i>Admin Remark
                        </label>
                        <textarea class="form-control" id="remark" name="remark" rows="3"
                                  placeholder="Add remarks or notes"
                                  maxlength="500"><%= (complaint != null && complaint.getRemarks() != null) ? complaint.getRemarks() : "" %>
                        </textarea>
                    </div>
                </div>
            </div>

            <!-- Form Footer -->
            <div class="form-footer">
                <div>
                    <small class="text-muted">
                        <i class="bi bi-info-circle me-1"></i>
                        All fields marked with <span class="required">*</span> are required
                    </small>
                </div>
                <div>
                    <a href="dashboard" class="btn btn-secondary me-2">
                        <i class="bi bi-x-circle me-1"></i>Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-lg me-1"></i><%= submitButtonText %>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
