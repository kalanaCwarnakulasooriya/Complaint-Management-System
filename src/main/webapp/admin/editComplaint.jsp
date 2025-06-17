<%--
  Created by IntelliJ IDEA.
  User: VivoBook
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
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.5rem;
        }

        .form-container {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin: 2rem auto;
            max-width: 900px;
        }

        .form-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .form-header h1 {
            margin: 0;
            font-size: 2rem;
            font-weight: 600;
        }

        .form-header p {
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
        }

        .form-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
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

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }

        .priority-badge, .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            margin-left: 0.5rem;
        }

        .priority-low { background-color: #d4edda; color: #155724; }
        .priority-medium { background-color: #fff3cd; color: #856404; }
        .priority-high { background-color: #f8d7da; color: #721c24; }
        .priority-urgent { background-color: #f5c6cb; color: #721c24; }

        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-in_progress { background-color: #cce5ff; color: #004085; }
        .status-resolved { background-color: #d4edda; color: #155724; }

        .form-section {
            margin-bottom: 2rem;
            padding: 1.5rem;
            background-color: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid var(--secondary-color);
        }

        .form-section h5 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .required {
            color: var(--danger-color);
        }

        .form-footer {
            background-color: #f8f9fa;
            padding: 1.5rem 2rem;
            border-top: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .character-count {
            font-size: 0.875rem;
            color: #6c757d;
            text-align: right;
            margin-top: 0.25rem;
        }

        .form-icon {
            color: var(--secondary-color);
            margin-right: 0.5rem;
        }

        .info-text {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }

        @media (max-width: 768px) {
            .form-container {
                margin: 1rem;
                border-radius: 8px;
            }

            .form-header {
                padding: 1.5rem;
            }

            .form-header h1 {
                font-size: 1.5rem;
            }

            .form-body {
                padding: 1.5rem;
            }

            .form-footer {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
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
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard">
            <i class="bi bi-clipboard-check me-2"></i>
            Complaint Management System
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link btn btn-outline-light btn-sm" href="dashboard">
                <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container-fluid py-4">
    <div class="form-container">
        <!-- Form Header -->
        <div class="form-header">
            <i class="bi bi-clipboard-plus display-4 mb-3"></i>
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
                    <h5><i class="bi bi-info-circle form-icon"></i>Basic Information</h5>
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
                                  maxlength="500"><%= (complaint != null && complaint.getRemarks() != null) ? complaint.getRemarks() : "" %></textarea>

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
                        <i class="bi bi-arrow-left me-1"></i>Cancel
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
