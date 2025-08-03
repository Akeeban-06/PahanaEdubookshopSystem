<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer - Pahana Edu Bookshop</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-book-open me-2"></i>Pahana Edu Bookshop
            </a>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-user-edit me-2"></i>Edit Customer</h4>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("success") != null) { %>
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
                            </div>
                        <% } %>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                            </div>
                        <% } %>

                        <% if (customer != null) { %>
                            <form method="post" action="${pageContext.request.contextPath}/customer/update">
                                <div class="mb-3">
                                    <label for="accountNumber" class="form-label">Account Number</label>
                                    <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                           value="<%= customer.getAccountNumber() %>" readonly>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="name" class="form-label">Customer Name *</label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="<%= customer.getName() %>" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea class="form-control" id="address" name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="text" class="form-control" id="phone" name="phone" 
                                           value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>">
                                </div>
                                
                                <div class="mb-3">
                                    <label for="unitsConsumed" class="form-label">Units Consumed</label>
                                    <input type="number" class="form-control" id="unitsConsumed" name="unitsConsumed" 
                                           value="<%= customer.getUnitsConsumed() %>" min="0">
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/customer/" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to List
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i> Update Customer
                                    </button>
                                </div>
                            </form>
                        <% } else { %>
                            <div class="alert alert-warning" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> Customer not found.
                            </div>
                            <a href="${pageContext.request.contextPath}/customer/" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>