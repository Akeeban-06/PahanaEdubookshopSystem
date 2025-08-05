<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    Item item = (Item) request.getAttribute("item");
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Item - Pahana Edu Bookshop</title>
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
        <% if (item != null) { %>
            <div class="form-card bg-white rounded-xl overflow-hidden border border-gray-200">
                <!-- Form Header -->
                <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-blue-50 to-blue-100">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 bg-blue-600 text-white p-3 rounded-lg">
                            <i class="ri-edit-box-line text-2xl"></i>
                        </div>
                        <div class="ml-4">
                            <h2 class="text-2xl font-bold text-gray-800">Edit Item</h2>
                            <p class="text-gray-600">Update details for <%= item.getItemName() %></p>
                        </div>
                    </div>
                </div>
                
                <!-- Form Body -->
                <div class="px-6 py-6">
                    <form method="post" action="${pageContext.request.contextPath}/item/update" class="space-y-6">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        
                        <!-- Item Name -->
                        <div>
                            <label for="itemName" class="block text-sm font-medium text-gray-700 mb-1">
                                Item Name <span class="text-red-500">*</span>
                            </label>
                            <div class="relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-book-line text-gray-400"></i>
                                </div>
                                <input type="text" id="itemName" name="itemName" required
                                       value="<%= item.getItemName() %>"
                                       class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                       placeholder="e.g., Mathematics Textbook">
                            </div>
                        </div>
                        
                        <!-- Price -->
                        <div>
                            <label for="price" class="block text-sm font-medium text-gray-700 mb-1">
                                Price (Rs.) <span class="text-red-500">*</span>
                            </label>
                            <div class="relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-money-dollar-circle-line text-gray-400"></i>
                                </div>
                                <input type="number" id="price" name="price" step="0.01" min="0" required
                                       value="<%= item.getPrice() %>"
                                       class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                       placeholder="0.00">
                            </div>
                        </div>
                        
                        <!-- Stock Quantity -->
                        <div>
                            <label for="stock" class="block text-sm font-medium text-gray-700 mb-1">
                                Stock Quantity <span class="text-red-500">*</span>
                            </label>
                            <div class="relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-stack-line text-gray-400"></i>
                                </div>
                                <input type="number" id="stock" name="stock" min="0" required
                                       value="<%= item.getStock() %>"
                                       class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                       placeholder="0">
                            </div>
                            <div class="mt-2">
                                <% if (item.getStock() > 10) { %>
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                        In Stock
                                    </span>
                                <% } else if (item.getStock() > 0) { %>
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                        Low Stock
                                    </span>
                                <% } else { %>
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                        Out of Stock
                                    </span>
                                <% } %>
                            </div>
                        </div>
                        
                        <!-- Form Actions -->
                        <div class="flex flex-col-reverse sm:flex-row sm:justify-between sm:space-x-3 space-y-3 sm:space-y-0 pt-4">
                            <a href="${pageContext.request.contextPath}/item/" 
                               class="inline-flex justify-center items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                                <i class="ri-arrow-left-line mr-2"></i> Back to List
                            </a>
                            <button type="submit" 
                                    class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                                <i class="ri-save-line mr-2"></i> Update Item
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        <% } else { %>
            <div class="bg-white shadow rounded-lg overflow-hidden border border-gray-200">
                <div class="px-6 py-6 text-center">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-yellow-100 text-yellow-600 mb-4">
                        <i class="ri-error-warning-line text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">Item Not Found</h3>
                    <p class="text-gray-500 mb-6">The item you're trying to edit doesn't exist or may have been deleted.</p>
                    <a href="${pageContext.request.contextPath}/item/" 
                       class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                        <i class="ri-arrow-left-line mr-2"></i> Back to Item List
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>