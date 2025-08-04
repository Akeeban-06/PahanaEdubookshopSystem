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
    <title>Add Customer - Pahana Edu Bookshop</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Inter', sans-serif;
        }
        
        .nav-gradient {
            background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
        }
        
        .form-card {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .form-card:hover {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .input-focus:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.2);
        }
        
        /* Toast notification styles */
        .toast {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 9999;
            max-width: 24rem;
            width: 100%;
            animation: slideIn 0.5s forwards, fadeOut 0.5s 4.5s forwards;
        }
        
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Toast Notifications -->
    <% if (request.getAttribute("success") != null) { %>
        <div class="toast">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 shadow-lg rounded-r-lg">
                <div class="flex items-center">
                    <div class="flex-shrink-0 text-green-500">
                        <i class="ri-checkbox-circle-fill text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium"><%= request.getAttribute("success") %></p>
                        <% if (request.getAttribute("generatedAccountNumber") != null) { %>
                            <p class="text-sm mt-1 font-semibold">
                                Generated Account Number: <%= request.getAttribute("generatedAccountNumber") %>
                            </p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="toast">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 shadow-lg rounded-r-lg">
                <div class="flex items-center">
                    <div class="flex-shrink-0 text-red-500">
                        <i class="ri-error-warning-fill text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium"><%= request.getAttribute("error") %></p>
                    </div>
                </div>
            </div>
        </div>
    <% } %>

    <!-- Navigation -->
    <nav class="nav-gradient text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <div class="flex items-center space-x-3">
                    <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center space-x-2">
                        <div class="flex items-center justify-center w-10 h-10 rounded-lg bg-white/20">
                            <i class="ri-book-open-line text-xl"></i>
                        </div>
                        <span class="font-bold text-xl tracking-tight">Pahana Edu Bookshop</span>
                    </a>
                </div>
                <div class="flex items-center space-x-6">
                    <div class="hidden md:flex items-center space-x-2 bg-white/10 px-4 py-2 rounded-full">
                        <div class="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center">
                            <i class="ri-user-line"></i>
                        </div>
                        <span class="font-medium"><%= currentUser.getUsername() %></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-2 bg-white/20 hover:bg-white/30 px-4 py-2 rounded-full transition-colors duration-200">
                        <i class="ri-logout-box-r-line"></i>
                        <span class="hidden sm:inline">Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="form-card bg-white rounded-xl overflow-hidden border border-gray-200">
            <!-- Form Header -->
            <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-blue-50 to-blue-100">
                <div class="flex items-center">
                    <div class="flex-shrink-0 bg-blue-600 text-white p-3 rounded-lg">
                        <i class="ri-user-add-line text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-2xl font-bold text-gray-800">Add New Customer</h2>
                        <p class="text-gray-600">Fill in the details below to register a new customer</p>
                    </div>
                </div>
            </div>
            
            <!-- Form Body -->
            <div class="px-6 py-6">
                <!-- Info Alert -->
                <div class="bg-blue-50 border-l-4 border-blue-500 text-blue-700 p-4 mb-6 rounded-r-lg">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 text-blue-500">
                            <i class="ri-information-line text-xl"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm">
                                <strong>Note:</strong> Account number will be generated automatically in the format ACC001, ACC002, etc.
                            </p>
                        </div>
                    </div>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/customer/add" class="space-y-6">
                    <!-- Customer Name -->
                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-1">
                            Customer Name <span class="text-red-500">*</span>
                        </label>
                        <div class="relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-user-3-line text-gray-400"></i>
                            </div>
                            <input type="text" id="name" name="name" required
                                   class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                   placeholder="John Doe">
                        </div>
                    </div>
                    
                    <!-- Address -->
                    <div>
                        <label for="address" class="block text-sm font-medium text-gray-700 mb-1">
                            Address
                        </label>
                        <div class="relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 pt-2 flex items-start pointer-events-none">
                                <i class="ri-map-pin-line text-gray-400"></i>
                            </div>
                            <textarea id="address" name="address" rows="3"
                                      class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                      placeholder="123 Main St, City, Country"></textarea>
                        </div>
                    </div>
                    
                    <!-- Phone Number -->
                    <div>
                        <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">
                            Phone Number
                        </label>
                        <div class="relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-phone-line text-gray-400"></i>
                            </div>
                            <input type="text" id="phone" name="phone"
                                   class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                   placeholder="+94771234567">
                        </div>
                    </div>
                    
                    <!-- Units Consumed -->
                    <div>
                        <label for="unitsConsumed" class="block text-sm font-medium text-gray-700 mb-1">
                            Units Consumed
                        </label>
                        <div class="relative rounded-md shadow-sm">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-battery-2-charge-line text-gray-400"></i>
                            </div>
                            <input type="number" id="unitsConsumed" name="unitsConsumed" value="0" min="0"
                                   class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                   placeholder="0">
                        </div>
                        <p class="mt-1 text-xs text-gray-500">Default is 0 for new customers</p>
                    </div>
                    
                    <!-- Form Actions -->
                    <div class="flex flex-col-reverse sm:flex-row sm:justify-between sm:space-x-3 space-y-3 sm:space-y-0 pt-4">
                        <a href="${pageContext.request.contextPath}/customer/" 
                           class="inline-flex justify-center items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                            <i class="ri-arrow-left-line mr-2"></i> Back to List
                        </a>
                        <button type="submit" 
                                class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                            <i class="ri-save-line mr-2"></i> Add Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>