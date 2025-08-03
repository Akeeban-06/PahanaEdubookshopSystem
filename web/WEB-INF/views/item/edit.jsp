<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%
    Item item = (Item) request.getAttribute("item");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Item - Pahana Edu Bookshop</title>
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
                        <h4><i class="fas fa-edit me-2"></i>Edit Item</h4>
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

                        <% if (item != null) { %>
                            <form method="post" action="${pageContext.request.contextPath}/item/update">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                
                                <div class="mb-3">
                                    <label for="itemName" class="form-label">Item Name *</label>
                                    <input type="text" class="form-control" id="itemName" name="itemName" 
                                           value="<%= item.getItemName() %>" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="price" class="form-label">Price (Rs.) *</label>
                                    <input type="number" class="form-control" id="price" name="price" step="0.01" min="0"
                                           value="<%= item.getPrice() %>" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="stock" class="form-label">Stock Quantity *</label>
                                    <input type="number" class="form-control" id="stock" name="stock" min="0"
                                           value="<%= item.getStock() %>" required>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/item/" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to List
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i> Update Item
                                    </button>
                                </div>
                            </form>
                        <% } else { %>
                            <div class="alert alert-warning" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> Item not found.
                            </div>
                            <a href="${pageContext.request.contextPath}/item/" class="btn btn-secondary">
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