<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Item Management - Pahana Edu Bookshop</title>
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
        
        .item-card {
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .item-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .stock-indicator {
            height: 8px;
            border-radius: 4px;
            transition: width 0.6s ease;
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
    <% String success = (String) request.getAttribute("success");
       String error = (String) request.getAttribute("error");
       if (success != null) { %>
        <div class="toast">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 shadow-lg rounded-r-lg">
                <div class="flex items-center">
                    <div class="flex-shrink-0 text-green-500">
                        <i class="ri-checkbox-circle-fill text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium"><%= success %></p>
                    </div>
                </div>
            </div>
        </div>
    <% }
       if (error != null) { %>
        <div class="toast">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 shadow-lg rounded-r-lg">
                <div class="flex items-center">
                    <div class="flex-shrink-0 text-red-500">
                        <i class="ri-error-warning-fill text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium"><%= error %></p>
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

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Page Header -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8">
            <div class="mb-4 sm:mb-0">
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800 flex items-center">
                    <i class="ri-book-open-line text-blue-600 mr-3"></i> Item Management
                </h1>
                <p class="text-gray-500 mt-1">Manage your inventory of books and stationery</p>
            </div>
            <div class="flex space-x-3">
                <a href="${pageContext.request.contextPath}/item/add" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                    <i class="ri-add-line mr-2"></i> Add New Item
                </a>
                <a href="${pageContext.request.contextPath}/dashboard" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                    <i class="ri-arrow-left-line mr-2"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Items List -->
        <% if (items != null && !items.isEmpty()) { %>
            <div class="bg-white shadow rounded-lg overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Item ID
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Item Name
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Price
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Stock
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Status
                                </th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% for (Item item : items) { %>
                                <tr class="item-card hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                        <%= item.getItemId() %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 rounded-md bg-blue-100 text-blue-600 flex items-center justify-center mr-3">
                                                <i class="ri-book-line"></i>
                                            </div>
                                            <div class="font-medium"><%= item.getItemName() %></div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        Rs. <%= String.format("%.2f", item.getPrice()) %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <div class="flex items-center">
                                            <div class="w-16 mr-2">
                                                <span class="font-medium"><%= item.getStock() %></span>
                                            </div>
                                            <div class="w-full bg-gray-200 rounded-full h-2">
                                                <div class="stock-indicator h-2 rounded-full 
                                                    <% if (item.getStock() > 10) { %> bg-green-500
                                                    <% } else if (item.getStock() > 0) { %> bg-yellow-500
                                                    <% } else { %> bg-red-500 <% } %>" 
                                                    style="width: <%= Math.min(100, item.getStock() * 10) %>%">
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
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
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                        <div class="flex justify-end space-x-2">
                                            <a href="${pageContext.request.contextPath}/item/edit?itemId=<%= item.getItemId() %>" 
                                               class="inline-flex items-center px-3 py-1 border border-transparent text-xs font-medium rounded-md shadow-sm text-white bg-yellow-500 hover:bg-yellow-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500 transition-colors">
                                                <i class="ri-edit-line"></i>
                                                <span class="ml-1 hidden sm:inline">Edit</span>
                                            </a>
                                            <button onclick="confirmDelete('<%= item.getItemId() %>', '<%= item.getItemName().replace("'", "\\'") %>')"
                                               class="inline-flex items-center px-3 py-1 border border-transparent text-xs font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors">
                                                <i class="ri-delete-bin-line"></i>
                                                <span class="ml-1 hidden sm:inline">Delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        <% } else { %>
            <div class="bg-white shadow rounded-lg overflow-hidden">
                <div class="text-center py-12">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-gray-100 text-gray-400 mb-4">
                        <i class="ri-box-2-line text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-1">No items found</h3>
                    <p class="text-gray-500 mb-6">Get started by adding your first item</p>
                    <a href="${pageContext.request.contextPath}/item/add" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                        <i class="ri-add-line mr-2"></i> Add Item
                    </a>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="fixed z-10 inset-0 overflow-y-auto hidden" id="deleteModal" aria-labelledby="modal-title" role="dialog" aria-modal="true">
        <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
            <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">
                            <i class="ri-error-warning-line text-red-600"></i>
                        </div>
                        <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">Confirm Delete</h3>
                            <div class="mt-2">
                                <p class="text-sm text-gray-500">Are you sure you want to delete the item "<span id="itemName" class="font-medium"></span>"?</p>
                                <p class="text-sm text-red-500 mt-1">This action cannot be undone.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                    <a id="deleteLink" href="#" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                        Delete
                    </a>
                    <button type="button" onclick="document.getElementById('deleteModal').classList.add('hidden')" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmDelete(itemId, itemName) {
            // Set the item name in the modal
            document.getElementById('itemName').textContent = itemName;
            
            // Set the delete link href
            document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/item/delete?itemId=' + itemId;
            
            // Show the modal
            document.getElementById('deleteModal').classList.remove('hidden');
        }
    </script>
</body>
</html>