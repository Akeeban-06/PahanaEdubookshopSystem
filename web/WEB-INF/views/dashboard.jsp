<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Pahana Edu Bookshop</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .dashboard-card { 
            transition: transform 0.3s; 
            border: none; 
            border-radius: 15px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.1); 
        }
        .dashboard-card:hover { transform: translateY(-5px); }
        .navbar-brand { font-weight: bold; }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-book-open me-2"></i>Pahana Edu Bookshop
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">Welcome, <%= currentUser.getUsername() %>!</span>
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h1 class="mb-4">Dashboard</h1>
            </div>
        </div>

        <div class="row g-4">
            <!-- Customer Management -->
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-users fa-3x text-primary"></i>
                        </div>
                        <h5 class="card-title">Customer Management</h5>
                        <p class="card-text">Add, edit, and manage customer accounts</p>
                        <a href="${pageContext.request.contextPath}/customer/" class="btn btn-primary">
                            <i class="fas fa-arrow-right"></i> Manage Customers
                        </a>
                    </div>
                </div>
            </div>

            <!-- Item Management -->
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-box fa-3x text-success"></i>
                        </div>
                        <h5 class="card-title">Item Management</h5>
                        <p class="card-text">Manage books, stationery and inventory</p>
                        <a href="${pageContext.request.contextPath}/item/" class="btn btn-success">
                            <i class="fas fa-arrow-right"></i> Manage Items
                        </a>
                    </div>
                </div>
            </div>

            <!-- Billing -->
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-receipt fa-3x text-warning"></i>
                        </div>
                        <h5 class="card-title">Billing System</h5>
                        <p class="card-text">Create bills and manage transactions</p>
                        <a href="${pageContext.request.contextPath}/bill/create" class="btn btn-warning">
                            <i class="fas fa-arrow-right"></i> Create Bill
                        </a>
                    </div>
                </div>
            </div>

            <!-- Reports -->
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-chart-bar fa-3x text-info"></i>
                        </div>
                        <h5 class="card-title">Reports</h5>
                        <p class="card-text">View sales reports and analytics</p>
                        <a href="#" class="btn btn-info">
                            <i class="fas fa-arrow-right"></i> View Reports
                        </a>
                    </div>
                </div>
            </div>

            <!-- Settings -->
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-cog fa-3x text-secondary"></i>
                        </div>
                        <h5 class="card-title">Settings</h5>
                        <p class="card-text">System configuration and preferences</p>
                        <a href="#" class="btn btn-secondary">
                            <i class="fas fa-arrow-right"></i> Settings
                        </a>
                    </div>
                </div>
            </div>

            <!-- Help -->
            <div class="col-md-6 col-lg-4">
                <div class="card dashboard-card h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="fas fa-question-circle fa-3x text-danger"></i>
                        </div>
                        <h5 class="card-title">Help & Support</h5>
                        <p class="card-text">System usage guidelines and support</p>
                        <a href="${pageContext.request.contextPath}/help" class="btn btn-danger">
                            <i class="fas fa-arrow-right"></i> Get Help
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>