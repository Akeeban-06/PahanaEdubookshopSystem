<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Details - Pahana Edu Bookshop</title>
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
        
        .detail-card {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .detail-card:hover {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .info-item {
            transition: all 0.2s ease;
        }
        
        .info-item:hover {
            background-color: #f8fafc;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
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
        <% if (customer != null) { %>
            <div class="detail-card bg-white rounded-xl overflow-hidden border border-gray-200">
                <!-- Card Header -->
                <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-blue-50 to-blue-100">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 bg-blue-600 text-white p-3 rounded-lg">
                            <i class="ri-user-line text-2xl"></i>
                        </div>
                        <div class="ml-4">
                            <h2 class="text-2xl font-bold text-gray-800">Customer Details</h2>
                            <p class="text-gray-600">Viewing details for <%= customer.getName() %></p>
                        </div>
                    </div>
                </div>
                
                <!-- Card Body -->
                <div class="px-6 py-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Customer Information -->
                        <div class="space-y-4">
                            <div class="info-item bg-gray-50 p-4 rounded-lg">
                                <div class="text-xs font-medium text-gray-500 uppercase tracking-wider">Account Number</div>
                                <div class="mt-1 text-lg font-semibold text-gray-900 flex items-center">
                                    <i class="ri-id-card-line text-blue-500 mr-2"></i>
                                    <%= customer.getAccountNumber() %>
                                </div>
                            </div>
                            
                            <div class="info-item bg-gray-50 p-4 rounded-lg">
                                <div class="text-xs font-medium text-gray-500 uppercase tracking-wider">Customer Name</div>
                                <div class="mt-1 text-lg font-semibold text-gray-900 flex items-center">
                                    <i class="ri-user-3-line text-blue-500 mr-2"></i>
                                    <%= customer.getName() %>
                                </div>
                            </div>
                            
                            <div class="info-item bg-gray-50 p-4 rounded-lg">
                                <div class="text-xs font-medium text-gray-500 uppercase tracking-wider">Address</div>
                                <div class="mt-1 text-gray-900 flex items-start">
                                    <i class="ri-map-pin-line text-blue-500 mr-2 mt-1"></i>
                                    <span><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Contact and Usage -->
                        <div class="space-y-4">
                            <div class="info-item bg-gray-50 p-4 rounded-lg">
                                <div class="text-xs font-medium text-gray-500 uppercase tracking-wider">Phone Number</div>
                                <div class="mt-1 text-gray-900 flex items-center">
                                    <i class="ri-phone-line text-blue-500 mr-2"></i>
                                    <%= customer.getPhone() != null ? customer.getPhone() : "N/A" %>
                                </div>
                            </div>
                            
                            <div class="info-item bg-gray-50 p-4 rounded-lg">
                                <div class="text-xs font-medium text-gray-500 uppercase tracking-wider">Units Consumed</div>
                                <div class="mt-1 flex items-center">
                                    <i class="ri-battery-2-charge-line text-blue-500 mr-2"></i>
                                    <div class="w-full">
                                        <div class="flex justify-between text-sm font-medium text-gray-900 mb-1">
                                            <span><%= customer.getUnitsConsumed() %> units</span>
                                            <span><%= Math.min(100, customer.getUnitsConsumed()) %>%</span>
                                        </div>
                                        <div class="w-full bg-gray-200 rounded-full h-2">
                                            <div class="bg-blue-600 h-2 rounded-full" style="width: <%= Math.min(100, customer.getUnitsConsumed()) %>%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="info-item bg-gray-50 p-4 rounded-lg">
                                <div class="text-xs font-medium text-gray-500 uppercase tracking-wider">Customer Since</div>
                                <div class="mt-1 text-gray-900 flex items-center">
                                    <i class="ri-calendar-line text-blue-500 mr-2"></i>
                                    <!-- You can add registration date if available in your model -->
                                    Active customer
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="flex flex-col-reverse sm:flex-row sm:justify-between sm:space-x-3 space-y-3 sm:space-y-0 pt-6 mt-6 border-t border-gray-200">
                        <a href="${pageContext.request.contextPath}/customer/" 
                           class="inline-flex justify-center items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                            <i class="ri-arrow-left-line mr-2"></i> Back to List
                        </a>
                        <div class="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-3">
                            <a href="${pageContext.request.contextPath}/customer/edit?accountNumber=<%= customer.getAccountNumber() %>" 
                               class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-yellow-500 hover:bg-yellow-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500 transition-colors">
                                <i class="ri-edit-line mr-2"></i> Edit Customer
                            </a>
                            <a href="${pageContext.request.contextPath}/bill/create?customerId=<%= customer.getCustomerId() %>" 
                               class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                                <i class="ri-bill-line mr-2"></i> Create Bill
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="bg-white shadow rounded-lg overflow-hidden border border-gray-200">
                <div class="px-6 py-6 text-center">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-yellow-100 text-yellow-600 mb-4">
                        <i class="ri-error-warning-line text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">Customer Not Found</h3>
                    <p class="text-gray-500 mb-6">The customer you're trying to view doesn't exist or may have been deleted.</p>
                    <a href="${pageContext.request.contextPath}/customer/" 
                       class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                        <i class="ri-arrow-left-line mr-2"></i> Back to Customer List
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>