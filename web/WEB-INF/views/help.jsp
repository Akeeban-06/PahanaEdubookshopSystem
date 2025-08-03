<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Help & Support - Pahana Edu Bookshop</title>
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
                        <h2><i class="fas fa-question-circle me-2"></i>Help & Support</h2>
                    </div>
                    <div class="card-body">
                        <div class="accordion" id="helpAccordion">
                            <!-- Getting Started -->
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#gettingStarted">
                                        <i class="fas fa-rocket me-2"></i>Getting Started
                                    </button>
                                </h2>
                                <div id="gettingStarted" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                                    <div class="accordion-body">
                                        <h5>Welcome to Pahana Edu Bookshop Management System!</h5>
                                        <p>This system helps you manage customer accounts, inventory, and billing efficiently.</p>
                                        <h6>Default Login Credentials:</h6>
                                        <ul>
                                            <li><strong>Username:</strong> admin</li>
                                            <li><strong>Password:</strong> admin123</li>
                                        </ul>
                                        <p><em>Please change the default password after first login for security.</em></p>
                                    </div>
                                </div>
                            </div>

                            <!-- Customer Management -->
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#customerManagement">
                                        <i class="fas fa-users me-2"></i>Customer Management
                                    </button>
                                </h2>
                                <div id="customerManagement" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                    <div class="accordion-body">
                                        <h6>Adding New Customers:</h6>
                                        <ol>
                                            <li>Go to Dashboard → Customer Management</li>
                                            <li>Click "Add New Customer"</li>
                                            <li>Fill in customer details (Account Number is mandatory and must be unique)</li>
                                            <li>Click "Add Customer" to save</li>
                                        </ol>
                                        
                                        <h6>Editing Customer Information:</h6>
                                        <ol>
                                            <li>From Customer List, click the edit (pencil) icon</li>
                                            <li>Update the required information</li>
                                            <li>Click "Update Customer" to save changes</li>
                                        </ol>
                                        
                                        <h6>Viewing Customer Details:</h6>
                                        <p>Click the view (eye) icon from the Customer List to see complete customer information.</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Item Management -->
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#itemManagement">
                                        <i class="fas fa-box me-2"></i>Item Management
                                    </button>
                                </h2>
                                <div id="itemManagement" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                    <div class="accordion-body">
                                        <h6>Adding New Items:</h6>
                                        <ol>
                                            <li>Go to Dashboard → Item Management</li>
                                            <li>Click "Add New Item"</li>
                                            <li>Enter item name, price, and stock quantity</li>
                                            <li>Click "Add Item" to save</li>
                                        </ol>
                                        
                                        <h6>Managing Stock:</h6>
                                        <ul>
                                            <li><span class="badge bg-success">In Stock</span> - More than 10 items available</li>
                                            <li><span class="badge bg-warning">Low Stock</span> - 1-10 items remaining</li>
                                            <li><span class="badge bg-danger">Out of Stock</span> - No items available</li>
                                        </ul>
                                        
                                        <h6>Updating Items:</h6>
                                        <p>Use the edit button to modify item details including name, price, and stock levels.</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Billing System -->
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#billingSystem">
                                        <i class="fas fa-receipt me-2"></i>Billing System
                                    </button>
                                </h2>
                                <div id="billingSystem" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                    <div class="accordion-body">
                                        <h6>Creating a New Bill:</h6>
                                        <ol>
                                            <li>Go to Dashboard → Billing System or click "Create Bill"</li>
                                            <li>Select the customer from the dropdown</li>
                                            <li>Choose items and specify quantities</li>
                                            <li>Use "Add Another Item" to include multiple items</li>
                                            <li>Review the total amount</li>
                                            <li>Click "Create Bill" to generate the bill</li>
                                        </ol>
                                        
                                        <h6>Important Notes:</h6>
                                        <ul>
                                            <li>Stock levels are automatically updated when bills are created</li>
                                            <li>You cannot sell more items than available in stock</li>
                                            <li>Bills can be printed for customer records</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- System Features -->
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#systemFeatures">
                                        <i class="fas fa-cogs me-2"></i>System Features
                                    </button>
                                </h2>
                                <div id="systemFeatures" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                    <div class="accordion-body">
                                        <h6>Key Features:</h6>
                                        <ul>
                                            <li><strong>User Authentication:</strong> Secure login system</li>
                                            <li><strong>Customer Management:</strong> Add, edit, view customer accounts</li>
                                            <li><strong>Inventory Management:</strong> Track books and stationery items</li>
                                            <li><strong>Billing System:</strong> Generate bills and manage transactions</li>
                                            <li><strong>Stock Control:</strong> Automatic stock updates</li>
                                            <li><strong>Print Support:</strong> Print bills for customers</li>
                                        </ul>
                                        
                                        <h6>Data Security:</h6>
                                        <ul>
                                            <li>All data is stored securely in the database</li>
                                            <li>User sessions are managed securely</li>
                                            <li>Regular logout is recommended for security</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- Troubleshooting -->
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#troubleshooting">
                                        <i class="fas fa-tools me-2"></i>Troubleshooting
                                    </button>
                                </h2>
                                <div id="troubleshooting" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                                    <div class="accordion-body">
                                        <h6>Common Issues:</h6>
                                        
                                        <h6>Login Problems:</h6>
                                        <ul>
                                            <li>Check username and password (default: admin/admin123)</li>
                                            <li>Ensure caps lock is off</li>
                                            <li>Clear browser cache if needed</li>
                                        </ul>
                                        
                                        <h6>Customer Registration Issues:</h6>
                                        <ul>
                                            <li>Account numbers must be unique</li>
                                            <li>All required fields must be filled</li>
                                        </ul>
                                        
                                        <h6>Billing Issues:</h6>
                                        <ul>
                                            <li>Ensure customer is selected</li>
                                            <li>Check item availability in stock</li>
                                            <li>Quantity cannot exceed available stock</li>
                                        </ul>
                                        
                                        <h6>Performance Tips:</h6>
                                        <ul>
                                            <li>Close unused browser tabs</li>
                                            <li>Use modern browsers (Chrome, Firefox, Edge)</li>
                                            <li>Ensure stable internet connection</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
