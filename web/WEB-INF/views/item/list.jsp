<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Item Management - Pahana Edu Bookshop</title>
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
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-box me-2"></i>Item Management</h2>
                    <a href="${pageContext.request.contextPath}/item/add" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Item
                    </a>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <% String success = request.getParameter("success");
                           String error = request.getParameter("error");
                           if (success != null) { %>
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle"></i> <%= success %>
                            </div>
                        <% }
                           if (error != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> <%= error %>
                            </div>
                        <% } %>

                        <% if (items != null && !items.isEmpty()) { %>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Item ID</th>
                                            <th>Item Name</th>
                                            <th>Price (Rs.)</th>
                                            <th>Stock</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Item item : items) { %>
                                            <tr>
                                                <td><%= item.getItemId() %></td>
                                                <td><%= item.getItemName() %></td>
                                                <td>Rs. <%= item.getPrice() %></td>
                                                <td><%= item.getStock() %></td>
                                                <td>
                                                    <% if (item.getStock() > 10) { %>
                                                        <span class="badge bg-success">In Stock</span>
                                                    <% } else if (item.getStock() > 0) { %>
                                                        <span class="badge bg-warning">Low Stock</span>
                                                    <% } else { %>
                                                        <span class="badge bg-danger">Out of Stock</span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <a href="${pageContext.request.contextPath}/item/edit?itemId=<%= item.getItemId() %>" 
                                                           class="btn btn-warning btn-sm">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-danger btn-sm" 
                                                                onclick="confirmDelete(<%= item.getItemId() %>, '<%= item.getItemName() %>')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } else { %>
                            <div class="text-center py-5">
                                <i class="fas fa-box fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">No items found</h4>
                                <p class="text-muted">Start by adding your first item</p>
                                <a href="${pageContext.request.contextPath}/item/add" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add Item
                                </a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-12">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the item "<span id="itemName"></span>"?</p>
                    <p class="text-danger"><small>This action cannot be undone.</small></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form method="post" id="deleteForm" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(itemId, itemName) {
            document.getElementById('itemName').textContent = itemName;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/item/delete?itemId=' + itemId;
            var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }
    </script>
</body>
</html>