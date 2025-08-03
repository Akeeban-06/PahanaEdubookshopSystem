<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Details - Pahana Edu Bookshop</title>
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
                        <h4><i class="fas fa-user me-2"></i>Customer Details</h4>
                    </div>
                    <div class="card-body">
                        <% if (customer != null) { %>
                            <div class="row">
                                <div class="col-md-6">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="40%">Account Number:</th>
                                            <td><%= customer.getAccountNumber() %></td>
                                        </tr>
                                        <tr>
                                            <th>Customer Name:</th>
                                            <td><%= customer.getName() %></td>
                                        </tr>
                                        <tr>
                                            <th>Address:</th>
                                            <td><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></td>
                                        </tr>
                                        <tr>
                                            <th>Phone Number:</th>
                                            <td><%= customer.getPhone() != null ? customer.getPhone() : "N/A" %></td>
                                        </tr>
                                        <tr>
                                            <th>Units Consumed:</th>
                                            <td><%= customer.getUnitsConsumed() %></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/customer/" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back to List
                                </a>
                                <div>
                                    <a href="${pageContext.request.contextPath}/customer/edit?accountNumber=<%= customer.getAccountNumber() %>" 
                                       class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Edit Customer
                                    </a>
                                    <a href="${pageContext.request.contextPath}/bill/create?customerId=<%= customer.getCustomerId() %>" 
                                       class="btn btn-primary">
                                        <i class="fas fa-receipt"></i> Create Bill
                                    </a>
                                </div>
                            </div>
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