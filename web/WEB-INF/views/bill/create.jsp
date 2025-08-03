<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Bill - Pahana Edu Bookshop</title>
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
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-receipt me-2"></i>Create New Bill</h4>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("error") %>
                            </div>
                        <% } %>

                        <form method="post" action="${pageContext.request.contextPath}/bill/create">
                            <!-- Customer Selection -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="customerId" class="form-label">Select Customer *</label>
                                    <select class="form-select" id="customerId" name="customerId" required>
                                        <option value="">Choose a customer...</option>
                                        <% if (customers != null) {
                                            for (Customer customer : customers) { %>
                                                <option value="<%= customer.getCustomerId() %>">
                                                    <%= customer.getAccountNumber() %> - <%= customer.getName() %>
                                                </option>
                                        <% }
                                        } %>
                                    </select>
                                </div>
                            </div>

                            <!-- Items Section -->
                            <div class="row">
                                <div class="col-12">
                                    <h5 class="mb-3">Select Items</h5>
                                    <div id="itemsContainer">
                                        <div class="row mb-3 item-row">
                                            <div class="col-md-6">
                                                <label class="form-label">Item</label>
                                                <select class="form-select item-select" name="itemId" onchange="updatePrice(this)">
                                                    <option value="">Choose an item...</option>
                                                    <% if (items != null) {
                                                        for (Item item : items) { %>
                                                            <option value="<%= item.getItemId() %>" 
                                                                    data-price="<%= item.getPrice() %>" 
                                                                    data-stock="<%= item.getStock() %>">
                                                                <%= item.getItemName() %> (Stock: <%= item.getStock() %>) - Rs. <%= item.getPrice() %>
                                                            </option>
                                                    <% }
                                                    } %>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Quantity</label>
                                                <input type="number" class="form-control quantity-input" name="quantity" 
                                                       min="1" value="1" onchange="calculateSubtotal(this)">
                                            </div>
                                            <div class="col-md-2">
                                                <label class="form-label">Subtotal</label>
                                                <input type="text" class="form-control subtotal" readonly value="Rs. 0.00">
                                            </div>
                                            <div class="col-md-1">
                                                <label class="form-label">&nbsp;</label>
                                                <button type="button" class="btn btn-danger btn-sm d-block" onclick="removeItem(this)">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-12">
                                            <button type="button" class="btn btn-success btn-sm" onclick="addItem()">
                                                <i class="fas fa-plus"></i> Add Another Item
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Total Section -->
                            <div class="row">
                                <div class="col-md-6 offset-md-6">
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <h5>Total Amount:</h5>
                                                <h5 id="totalAmount">Rs. 0.00</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Create Bill
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
         function addItem() {
            const container = document.getElementById('itemsContainer');
            const newRow = container.querySelector('.item-row').cloneNode(true);
            
            // Reset values
            newRow.querySelector('.item-select').value = '';
            newRow.querySelector('.quantity-input').value = '1';
            newRow.querySelector('.subtotal').value = 'Rs. 0.00';
            
            container.appendChild(newRow);
        }

        function removeItem(button) {
            const container = document.getElementById('itemsContainer');
            if (container.children.length > 1) {
                button.closest('.item-row').remove();
                calculateTotal();
            }
        }

        function updatePrice(select) {
            const row = select.closest('.item-row');
            const quantityInput = row.querySelector('.quantity-input');
            const subtotalInput = row.querySelector('.subtotal');
            
            if (select.value) {
                const selectedOption = select.options[select.selectedIndex];
                const stock = parseInt(selectedOption.dataset.stock);
                quantityInput.max = stock;
                
                if (parseInt(quantityInput.value) > stock) {
                    quantityInput.value = stock;
                }
                
                calculateSubtotal(quantityInput);
            } else {
                subtotalInput.value = 'Rs. 0.00';
                calculateTotal();
            }
        }

        function calculateSubtotal(quantityInput) {
            const row = quantityInput.closest('.item-row');
            const select = row.querySelector('.item-select');
            const subtotalInput = row.querySelector('.subtotal');
            
            if (select.value && quantityInput.value) {
                const selectedOption = select.options[select.selectedIndex];
                const price = parseFloat(selectedOption.dataset.price);
                const quantity = parseInt(quantityInput.value);
                const subtotal = price * quantity;
                
                subtotalInput.value = 'Rs. ' + subtotal.toFixed(2);
            } else {
                subtotalInput.value = 'Rs. 0.00';
            }
            
            calculateTotal();
        }

        function calculateTotal() {
            let total = 0;
            const subtotals = document.querySelectorAll('.subtotal');
            
            subtotals.forEach(function(subtotalInput) {
                const value = subtotalInput.value.replace('Rs. ', '');
                if (value && !isNaN(value)) {
                    total += parseFloat(value);
                }
            });
            
            document.getElementById('totalAmount').textContent = 'Rs. ' + total.toFixed(2);
        }
    </script>
</body>
</html>