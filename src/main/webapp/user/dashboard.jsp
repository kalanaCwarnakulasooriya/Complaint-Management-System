<%--
  Created by IntelliJ IDEA.
  User: Kalana Warnakulasooriya
  Date: 6/15/2025
  Time: 4:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard - CMS</title>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <!-- Bootstrap & FontAwesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f8f9fa;
    }

    :root {
      --primary-color: #2c3e50;
      --secondary-color: #3498db;
    }

    .navbar-custom {
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
    }

    .card {
      border-radius: 15px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }

    .border-warning-custom {
      border: 2px solid #f1c40f !important;
    }

    .border-info-custom {
      border: 2px solid #17a2b8 !important;
    }

    .border-success-custom {
      border: 2px solid #28a745 !important;
    }

    .border-primary-custom {
      border: 2px solid #007bff !important;
    }

    .navbar .btn-sm {
      padding: 0.3rem 0.6rem;
      font-size: 0.8rem;
    }

    .navbar .form-control-sm {
      width: 200px;
    }

    .navbar-brand .badge {
      font-size: 0.8rem;
      margin-left: 1rem;
    }

    .search-icon {
      position: absolute;
      top: 50%;
      left: 12px;
      transform: translateY(-50%);
      color: #999;
    }

    .search-container {
      position: relative;
    }

    .search-input {
      padding-left: 2.1rem !important;
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
  <div class="container-fluid">
    <span class="navbar-brand mb-0 h1 d-flex align-items-center">
<%--      <i class="fas fa-clipboard-list me-2"></i>Complaint Management System--%>
      <span class="badge bg-light text-dark d-flex align-items-center ms-3">
        <i class="fas fa-user-shield me-1"></i>Employee Panel - C M S
      </span>
    </span>

    <!-- Toggle for mobile -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarContent">
      <form class="d-flex me-3" role="search">
        <div class="search-container">
          <i class="fas fa-search search-icon"></i>
          <input class="form-control form-control-sm search-input" type="search" id="searchInput"
                 placeholder="Search complaints" onkeyup="filterComplaints()">
        </div>
      </form>
      <a href="addComplaint.jsp" class="btn btn-light btn-sm me-2">
        <i class="fas fa-plus me-1"></i>Add
      </a>
      <a href="logout" class="btn btn-light btn-sm">
        <i class="fas fa-sign-out-alt me-1"></i>Logout
      </a>
    </div>
  </div>
</nav>

<!-- Main Content -->
<div class="container py-5">
  <h2 class="mb-4 fw-semibold">Dashboard Overview</h2>

  <!-- Stats Cards -->
  <div class="row g-4 mb-4">
    <div class="col-md-3 col-sm-6">
      <div class="card text-center text-warning border-warning-custom">
        <div class="card-body">
          <i class="fas fa-clock fa-2x mb-2"></i>
          <h4 class="fw-bold">--</h4>
          <p class="text-muted">Pending</p>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="card text-center text-info border-info-custom">
        <div class="card-body">
          <i class="fas fa-spinner fa-2x mb-2"></i>
          <h4 class="fw-bold">--</h4>
          <p class="text-muted">In Progress</p>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="card text-center text-success border-success-custom">
        <div class="card-body">
          <i class="fas fa-check-circle fa-2x mb-2"></i>
          <h4 class="fw-bold">--</h4>
          <p class="text-muted">Resolved</p>
        </div>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="card text-center text-primary border-primary-custom">
        <div class="card-body">
          <i class="fas fa-list fa-2x mb-2"></i>
          <h4 class="fw-bold">--</h4>
          <p class="text-muted">Total</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Complaints Table -->
  <div class="card">
    <div class="card-header bg-white border-bottom-0">
      <h5 class="mb-0 fw-semibold"><i class="fas fa-table me-2"></i>Complaints Management</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle">
          <thead>
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody id="complaintsTableBody">
          <!-- Complaints will be dynamically loaded here via JSP -->
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  function filterComplaints() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.getElementById('complaintsTableBody').getElementsByTagName('tr');
    for (let row of rows) {
      const cells = row.getElementsByTagName('td');
      let match = false;
      for (let i = 0; i < cells.length - 1; i++) {
        if (cells[i].textContent.toLowerCase().includes(input)) {
          match = true;
          break;
        }
      }
      row.style.display = match ? '' : 'none';
    }
  }
</script>
</body>
</html>