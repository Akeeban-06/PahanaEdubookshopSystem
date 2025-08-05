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
    <title>Help & Support - Pahana Edu Bookshop</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
        }
        
        .nav-gradient {
            background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
        }
        
        .help-card {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02);
            transition: all 0.3s ease;
        }
        
        .help-card:hover {
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
        
        .accordion-item {
            transition: all 0.3s ease;
            border-radius: 0.5rem;
            overflow: hidden;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
        }
        
        .accordion-item:hover {
            border-color: #cbd5e1;
        }
        
        .accordion-button {
            transition: all 0.3s ease;
            background-color: white;
            color: #1e293b;
            font-weight: 500;
            padding: 1.25rem 1.5rem;
            width: 100%;
            text-align: left;
            display: flex;
            align-items: center;
            border: none;
            outline: none;
            cursor: pointer;
        }
        
        .accordion-button:hover {
            background-color: #f8fafc;
        }
        
        .accordion-button:not(.collapsed) {
            background-color: #f8fafc;
            color: #0ea5e9;
            box-shadow: none;
        }
        
        .accordion-button:after {
            content: '\F229';
            font-family: 'remixicon';
            font-size: 1.25rem;
            margin-left: auto;
            transition: transform 0.3s ease;
            color: #64748b;
        }
        
        .accordion-button:not(.collapsed):after {
            transform: rotate(180deg);
            color: #0ea5e9;
        }
        
        .accordion-button:focus {
            box-shadow: none;
        }
        
        .accordion-body {
            padding: 1.5rem;
            background-color: white;
            border-top: 1px solid #f1f5f9;
            display: none;
            transition: all 0.3s ease;
        }
        
        .accordion-body.show {
            display: block;
        }
        
        .feature-icon {
            background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            font-size: 1.5rem;
            margin-right: 0.75rem;
        }
        
        .back-btn {
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            transform: translateX(-4px);
        }
        
        .search-box {
            transition: all 0.3s ease;
        }
        
        .search-box:focus {
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.2);
        }
        
        .contact-card {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            transition: all 0.3s ease;
        }
        
        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body class="min-h-screen">
    <!-- Navigation -->
    <nav class="nav-gradient text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <div class="flex items-center space-x-3">
                    <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center space-x-2">
                        <div class="flex items-center justify-center w-10 h-10 rounded-lg bg-white/20 backdrop-blur-sm">
                            <i class="ri-book-open-line text-xl"></i>
                        </div>
                        <span class="font-bold text-xl tracking-tight">Pahana Edu Bookshop</span>
                    </a>
                </div>
                <div class="flex items-center space-x-6">
                    <div class="hidden md:flex items-center space-x-2 bg-white/10 px-4 py-2 rounded-full backdrop-blur-sm">
                        <div class="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center">
                            <i class="ri-user-line"></i>
                        </div>
                        <span class="font-medium"><%= currentUser.getUsername() %></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-2 bg-white/20 hover:bg-white/30 px-4 py-2 rounded-full transition-colors duration-200 backdrop-blur-sm">
                        <i class="ri-logout-box-r-line"></i>
                        <span class="hidden sm:inline">Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Search and Contact Section -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
            <div class="lg:col-span-2">
                <div class="help-card bg-white rounded-xl overflow-hidden border border-gray-200">
                    <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-blue-50 to-blue-100">
                        <div class="flex items-center">
                            <div class="flex-shrink-0 bg-blue-600 text-white p-3 rounded-lg">
                                <i class="ri-question-line text-2xl"></i>
                            </div>
                            <div class="ml-4">
                                <h1 class="text-2xl font-bold text-gray-800">Help Center</h1>
                                <p class="text-gray-600">Find answers to your questions or contact our support team</p>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="relative">
                            <input type="text" placeholder="Search help articles..." class="search-box w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <i class="ri-search-line absolute left-3 top-3.5 text-gray-400"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="contact-card rounded-xl border border-gray-200 p-6 bg-white">
                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                    <i class="ri-customer-service-2-line feature-icon mr-2"></i> Contact Support
                </h2>
                <div class="space-y-4">
                    <div class="flex items-start">
                        <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                            <i class="ri-mail-line text-lg"></i>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-sm font-medium text-gray-500">Email</h3>
                            <a href="mailto:support@pahanaedu.com" class="text-base text-blue-600 hover:underline">support@pahanaedu.com</a>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                            <i class="ri-phone-line text-lg"></i>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-sm font-medium text-gray-500">Phone</h3>
                            <a href="tel:+94112345678" class="text-base text-blue-600 hover:underline">+94 112 345 678</a>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                            <i class="ri-time-line text-lg"></i>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-sm font-medium text-gray-500">Hours</h3>
                            <p class="text-base text-gray-600">Monday - Friday, 8:30 AM - 5:30 PM</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- FAQ Section -->
        <div class="help-card bg-white rounded-xl overflow-hidden border border-gray-200 mb-8">
            <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-blue-50 to-blue-100">
                <h2 class="text-xl font-bold text-gray-800 flex items-center">
                    <i class="ri-question-answer-line feature-icon mr-2"></i> Supports
                </h2>
            </div>
            
            <div class="p-6">
                <div class="accordion" id="helpAccordion">
                    <!-- Getting Started -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="gettingStartedHeading">
                            <button class="accordion-button collapsed" type="button" data-target="#gettingStarted">
                                <i class="ri-rocket-line feature-icon"></i> Getting Started
                            </button>
                        </h2>
                        <div id="gettingStarted" class="accordion-body">
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Welcome to Pahana Edu Bookshop Management System!</h3>
                            <p class="text-gray-600 mb-4">This system helps you manage customer accounts, inventory, and billing efficiently.</p>
                            
                            <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-r-lg mb-4">
                                <h4 class="font-medium text-blue-800 mb-2">Default Login Credentials:</h4>
                                <ul class="list-disc pl-5 text-blue-700">
                                    <li><strong>Username:</strong> admin</li>
                                    <li><strong>Password:</strong> admin123</li>
                                </ul>
                                <p class="text-blue-600 mt-2 text-sm"><i class="ri-information-line"></i> Please change the default password after first login for security.</p>
                            </div>
                            
<!--                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                                <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                    <h4 class="font-medium text-gray-800 mb-2 flex items-center">
                                        <i class="ri-video-line text-blue-500 mr-2"></i> Video Tutorial
                                    </h4>
                                    <p class="text-gray-600 text-sm mb-2">Watch our getting started guide</p>
                                    <a href="#" class="text-blue-600 text-sm font-medium hover:underline flex items-center">
                                        Play video <i class="ri-arrow-right-line ml-1"></i>
                                    </a>
                                </div>
                                <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                    <h4 class="font-medium text-gray-800 mb-2 flex items-center">
                                        <i class="ri-file-text-line text-blue-500 mr-2"></i> User Guide
                                    </h4>
                                    <p class="text-gray-600 text-sm mb-2">Download the complete manual</p>
                                    <a href="#" class="text-blue-600 text-sm font-medium hover:underline flex items-center">
                                        Download PDF <i class="ri-download-line ml-1"></i>
                                    </a>
                                </div>
                            </div>-->
                        </div>
                    </div>

                    <!-- Customer Management -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="customerManagementHeading">
                            <button class="accordion-button collapsed" type="button" data-target="#customerManagement">
                                <i class="ri-group-line feature-icon"></i> Customer Management
                            </button>
                        </h2>
                        <div id="customerManagement" class="accordion-body">
                            <div class="space-y-4">
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Adding New Customers:</h4>
                                    <ol class="list-decimal pl-5 space-y-2 text-gray-600">
                                        <li>Go to Dashboard → Customer Management</li>
                                        <li>Click "Add New Customer"</li>
                                        <li>Fill in customer details (Account Number is mandatory and must be unique)</li>
                                        <li>Click "Add Customer" to save</li>
                                    </ol>
                                </div>
                                
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Editing Customer Information:</h4>
                                    <ol class="list-decimal pl-5 space-y-2 text-gray-600">
                                        <li>From Customer List, click the edit (pencil) icon</li>
                                        <li>Update the required information</li>
                                        <li>Click "Update Customer" to save changes</li>
                                    </ol>
                                </div>
                                
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Viewing Customer Details:</h4>
                                    <p class="text-gray-600">Click the view (eye) icon from the Customer List to see complete customer information.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Item Management -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="itemManagementHeading">
                            <button class="accordion-button collapsed" type="button" data-target="#itemManagement">
                                <i class="ri-box-2-line feature-icon"></i> Item Management
                            </button>
                        </h2>
                        <div id="itemManagement" class="accordion-body">
                            <div class="space-y-4">
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Adding New Items:</h4>
                                    <ol class="list-decimal pl-5 space-y-2 text-gray-600">
                                        <li>Go to Dashboard → Item Management</li>
                                        <li>Click "Add New Item"</li>
                                        <li>Enter item name, price, and stock quantity</li>
                                        <li>Click "Add Item" to save</li>
                                    </ol>
                                </div>
                                
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Managing Stock:</h4>
                                    <div class="space-y-2">
                                        <div class="flex items-center">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800 mr-2">In Stock</span>
                                            <span class="text-gray-600">More than 10 items available</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800 mr-2">Low Stock</span>
                                            <span class="text-gray-600">1-10 items remaining</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800 mr-2">Out of Stock</span>
                                            <span class="text-gray-600">No items available</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Updating Items:</h4>
                                    <p class="text-gray-600">Use the edit button to modify item details including name, price, and stock levels. Price changes will automatically update in all pending bills.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Billing System -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="billingSystemHeading">
                            <button class="accordion-button collapsed" type="button" data-target="#billingSystem">
                                <i class="ri-bill-line feature-icon"></i> Billing System
                            </button>
                        </h2>
                        <div id="billingSystem" class="accordion-body">
                            <div class="space-y-4">
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Creating a New Bill:</h4>
                                    <ol class="list-decimal pl-5 space-y-2 text-gray-600">
                                        <li>Go to Dashboard → Billing System or click "Create Bill"</li>
                                        <li>Select the customer from the dropdown</li>
                                        <li>Choose items and specify quantities</li>
                                        <li>Use "Add Another Item" to include multiple items</li>
                                        <li>Review the total amount</li>
                                        <li>Click "Create Bill" to generate the bill</li>
                                    </ol>
                                </div>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div class="bg-yellow-50 border-l-4 border-yellow-500 p-4 rounded-r-lg">
                                        <h4 class="font-medium text-yellow-800 mb-2">Important Notes:</h4>
                                        <ul class="list-disc pl-5 text-gray-600">
                                            <li>Account numbers must be unique</li>
                                            <li>All required fields must be filled</li>
                                            <li>Check for special characters in fields</li>
                                            <li>Ensure date formats are correct</li>
                                        </ul>
                                    </div>
                                    
                                    <div>
                                        <h5 class="font-medium text-gray-700 mb-2">Billing Issues:</h5>
                                        <ul class="list-disc pl-5 text-gray-600">
                                            <li>Ensure customer is selected</li>
                                            <li>Check item availability in stock</li>
                                            <li>Quantity cannot exceed available stock</li>
                                            <li>Verify payment method is selected</li>
                                        </ul>
                                    </div>
                                </div>
                                
                                <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-r-lg">
                                    <h5 class="font-medium text-blue-800 mb-2">Still Need Help?</h5>
                                    <p class="text-blue-700 mb-3">If you're still experiencing issues, please contact our support team with details about the problem you're encountering.</p>
                                    <a href="#" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        <i class="ri-customer-service-2-line mr-2"></i> Contact Support
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- System Features -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="systemFeaturesHeading">
                            <button class="accordion-button collapsed" type="button" data-target="#systemFeatures">
                                <i class="ri-customer-service-line feature-icon"></i> System Features
                            </button>
                        </h2>
                        <div id="systemFeatures" class="accordion-body">
                            <div class="space-y-4">
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Key Features:</h4>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div class="flex items-start bg-gray-50 p-3 rounded-lg">
                                            <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                                                <i class="ri-shield-keyhole-line text-lg"></i>
                                            </div>
                                            <div class="ml-3">
                                                <h5 class="font-medium text-gray-700">User Authentication</h5>
                                                <p class="text-gray-600 text-sm">Secure login system with role-based access control</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start bg-gray-50 p-3 rounded-lg">
                                            <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                                                <i class="ri-group-line text-lg"></i>
                                            </div>
                                            <div class="ml-3">
                                                <h5 class="font-medium text-gray-700">Customer Management</h5>
                                                <p class="text-gray-600 text-sm">Add, edit, view customer accounts with purchase history</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start bg-gray-50 p-3 rounded-lg">
                                            <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                                                <i class="ri-box-2-line text-lg"></i>
                                            </div>
                                            <div class="ml-3">
                                                <h5 class="font-medium text-gray-700">Inventory Management</h5>
                                                <p class="text-gray-600 text-sm">Track books and stationery items with low stock alerts</p>
                                            </div>
                                        </div>
                                        <div class="flex items-start bg-gray-50 p-3 rounded-lg">
                                            <div class="flex-shrink-0 bg-blue-100 p-2 rounded-lg text-blue-600">
                                                <i class="ri-bill-line text-lg"></i>
                                            </div>
                                            <div class="ml-3">
                                                <h5 class="font-medium text-gray-700">Billing System</h5>
                                                <p class="text-gray-600 text-sm">Generate bills, manage transactions, and print receipts</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Data Security:</h4>
                                    <ul class="list-disc pl-5 text-gray-600">
                                        <li>All data is encrypted and stored securely in the database</li>
                                        <li>User sessions are managed securely with automatic timeout</li>
                                        <li>Regular logout is recommended for security</li>
                                        <li>Role-based access control ensures users only see what they need</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Troubleshooting -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="troubleshootingHeading">
                            <button class="accordion-button collapsed" type="button" data-target="#troubleshooting">
                                <i class="ri-tools-line feature-icon"></i> Troubleshooting
                            </button>
                        </h2>
                        <div id="troubleshooting" class="accordion-body">
                            <div class="space-y-6">
                                <div>
                                    <h4 class="font-semibold text-gray-800 mb-2">Common Issues:</h4>
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg">
                                            <h5 class="font-medium text-red-800 mb-2">Login Problems:</h5>
                                            <ul class="list-disc pl-5 text-red-700">
                                                <li>Check username and password</li>
                                                <li>Ensure caps lock is off</li>
                                                <li>Clear browser cache if needed</li>
                                                <li>Try resetting your password</li>
                                            </ul>
                                        </div>
                                        <div class="bg-orange-50 border-l-4 border-orange-500 p-4 rounded-r-lg">
                                            <h5 class="font-medium text-orange-800 mb-2">Performance Issues:</h5>
                                            <ul class="list-disc pl-5 text-orange-700">
                                                <li>Close unused browser tabs</li>
                                                <li>Use modern browsers (Chrome, Firefox, Edge)</li>
                                                <li>Ensure stable internet connection</li>
                                                <li>Clear browser cache periodically</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div>
                                        <h5 class="font-medium text-gray-700 mb-2">Customer Registration Issues:</h5>
                                        <ul class="list-disc pl-5 text-gray-600">
                                            <li>Ensure all required fields are filled</li>
                                            <li>Verify email format if email is provided</li>
                                            <li>Ensure phone numbers contain only digits</li>
                                        </ul>
                                    </div>
                                    <div>
                                        <h5 class="font-medium text-gray-700 mb-2">Item Management Issues:</h5>
                                        <ul class="list-disc pl-5 text-gray-600">
                                            <li>Check for special characters in item names</li>
                                            <li>Ensure prices are numeric values</li>
                                            <li>Stock quantities must be whole numbers</li>
                                        </ul>
                                    </div>
                                </div>
                                
                                <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-r-lg">
                                    <h5 class="font-medium text-blue-800 mb-2">System Errors:</h5>
                                    <p class="text-blue-700 mb-3">If you encounter system errors, please note the error message and contact our support team with the following information:</p>
                                    <ul class="list-disc pl-5 text-blue-700 mb-4">
                                        <li>Date and time of the error</li>
                                        <li>Steps leading to the error</li>
                                        <li>Screenshot of the error message (if possible)</li>
                                        <li>Browser and operating system version</li>
                                    </ul>
                                    <a href="#" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        <i class="ri-bug-line mr-2"></i> Report a Bug
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Back Button -->
        <div class="flex justify-start mt-6">
            <a href="${pageContext.request.contextPath}/dashboard" 
               class="back-btn inline-flex justify-center items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                <i class="ri-arrow-left-line mr-2"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <script>
        // Custom accordion functionality
        document.addEventListener('DOMContentLoaded', function() {
            const accordionButtons = document.querySelectorAll('.accordion-button');
            
            accordionButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const targetId = this.getAttribute('data-target');
                    const targetElement = document.querySelector(targetId);
                    const isCollapsed = this.classList.contains('collapsed');
                    
                    // Close all other accordion items
                    accordionButtons.forEach(otherButton => {
                        if (otherButton !== this) {
                            otherButton.classList.add('collapsed');
                            const otherTargetId = otherButton.getAttribute('data-target');
                            const otherTargetElement = document.querySelector(otherTargetId);
                            otherTargetElement.classList.remove('show');
                        }
                    });
                    
                    // Toggle current accordion item
                    if (isCollapsed) {
                        this.classList.remove('collapsed');
                        targetElement.classList.add('show');
                        
                        // Smooth scroll to the accordion item
                        setTimeout(() => {
                            this.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                        }, 300);
                    } else {
                        this.classList.add('collapsed');
                        targetElement.classList.remove('show');
                    }
                });
            });
            
            // Simple search functionality
            document.querySelector('.search-box').addEventListener('input', function(e) {
                const searchTerm = e.target.value.toLowerCase();
                const accordionItems = document.querySelectorAll('.accordion-item');
                
                if (searchTerm === '') {
                    // Reset all items when search is empty
                    accordionItems.forEach(item => {
                        item.style.display = 'block';
                        const button = item.querySelector('.accordion-button');
                        const body = item.querySelector('.accordion-body');
                        button.classList.add('collapsed');
                        body.classList.remove('show');
                    });
                    return;
                }
                
                accordionItems.forEach(item => {
                    const headerText = item.querySelector('.accordion-button').textContent.toLowerCase();
                    const bodyText = item.querySelector('.accordion-body').textContent.toLowerCase();
                    
                    if (headerText.includes(searchTerm) || bodyText.includes(searchTerm)) {
                        item.style.display = 'block';
                        // Auto-expand matching items
                        const button = item.querySelector('.accordion-button');
                        const body = item.querySelector('.accordion-body');
                        button.classList.remove('collapsed');
                        body.classList.add('show');
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>