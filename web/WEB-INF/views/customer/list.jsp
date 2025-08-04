<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    String successMessage = (String) request.getAttribute("success");
    String errorMessage = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Customer Management - Pahana Edu Bookshop</title>
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

            .table-row-hover:hover {
                background-color: #f8fafc;
            }

            .action-btn {
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                transform: translateY(-1px);
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
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes fadeOut {
                from {
                    opacity: 1;
                }
                to {
                    opacity: 0;
                }
            }

            /* Beautiful table styles */
            .elegant-table {
                border-collapse: separate;
                border-spacing: 0;
            }

            .elegant-table thead th {
                background-color: #f8fafc;
                position: sticky;
                top: 0;
                z-index: 10;
            }

            .elegant-table tbody tr:not(:last-child) td {
                border-bottom: 1px solid #e2e8f0;
            }

            .elegant-table tbody tr td:first-child {
                border-left: 1px solid #e2e8f0;
            }

            .elegant-table tbody tr td:last-child {
                border-right: 1px solid #e2e8f0;
            }

            .elegant-table tbody tr:first-child td {
                border-top: 1px solid #e2e8f0;
            }

            .elegant-table tbody tr:hover td {
                background-color: #f8fafc;
            }
        </style>
    </head>
    <body class="bg-gray-50 min-h-screen">
        <!-- Toast Notifications -->
        <% if (successMessage != null) { %>
        <div class="toast">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 shadow-lg rounded-r-lg">
                <div class="flex items-center">
                    <div class="flex-shrink-0 text-green-500">
                        <i class="ri-checkbox-circle-fill text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium"><%= successMessage %></p>
                    </div>
                </div>
            </div>
        </div>
        <% } %>

        <% if (errorMessage != null) { %>
        <div class="toast">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 shadow-lg rounded-r-lg">
                <div class="flex items-center">
                    <div class="flex-shrink-0 text-red-500">
                        <i class="ri-error-warning-fill text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium"><%= errorMessage %></p>
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
                        <i class="ri-group-line text-primary-600 mr-3"></i> Customer Management
                    </h1>
                    <p class="text-gray-500 mt-1">Manage all your customer accounts and information</p>
                </div>
                <div class="flex space-x-3">
                    <a href="${pageContext.request.contextPath}/customer/add" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                        <i class="ri-user-add-line mr-2"></i> Add New Customer
                    </a>
                    <a href="${pageContext.request.contextPath}/dashboard" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md shadow-sm text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 transition-colors">
                        <i class="ri-arrow-left-line mr-2"></i> Back to Dashboard
                    </a>
                </div>
            </div>

            <!-- Customer Table -->
            <div class="bg-white shadow rounded-lg overflow-hidden">
                <% if (customers != null && !customers.isEmpty()) { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full elegant-table">
                        <thead class="">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider border-b border-gray-200">
                                    Account Number
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider border-b border-gray-200">
                                    Name
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider border-b border-gray-200 hidden md:table-cell">
                                    Address
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider border-b border-gray-200">
                                    Phone
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider border-b border-gray-200 hidden sm:table-cell">
                                    Units Consumed
                                </th>
                                <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider border-b border-gray-200">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% for (Customer customer : customers) { %>
                            <tr class="table-row-hover">
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center mr-3">
                                            <i class="ri-user-3-line"></i>
                                        </div>
                                        <div>
                                            <div class="font-medium text-gray-900"><%= customer.getAccountNumber() %></div>
                                            <div class="text-gray-500 text-xs">Active</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <div class="font-medium text-gray-900"><%= customer.getName() %></div>
                                    <div class="text-gray-500 text-xs">Customer</div>
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-500 hidden md:table-cell">
                                    <div class="max-w-xs truncate"><%= customer.getAddress() %></div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <div class="flex items-center">
                                        <i class="ri-phone-line mr-2 text-gray-400"></i>
                                        <%= customer.getPhone() %>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 hidden sm:table-cell">
                                    <div class="flex items-center">
                                        <div class="w-full bg-gray-200 rounded-full h-2.5 mr-2">
                                            <div class="bg-blue-600 h-2.5 rounded-full" style="width: <%= Math.min(100, customer.getUnitsConsumed()) %>%"></div>
                                        </div>
                                        <span><%= customer.getUnitsConsumed() %></span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <div class="flex justify-end space-x-2">
                                        <a href="${pageContext.request.contextPath}/customer/view?accountNumber=<%= customer.getAccountNumber() %>" 
                                           class="action-btn inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-full text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 shadow-sm"
                                           title="View">
                                            <i class="ri-eye-line"></i>
                                            <span class="ml-1 hidden sm:inline">View</span>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/customer/edit?accountNumber=<%= customer.getAccountNumber() %>" 
                                           class="action-btn inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-full text-white bg-yellow-500 hover:bg-yellow-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500 shadow-sm"
                                           title="Edit">
                                            <i class="ri-edit-line"></i>
                                            <span class="ml-1 hidden sm:inline">Edit</span>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/customer/delete?accountNumber=<%= customer.getAccountNumber() %>" 
                                           class="action-btn inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-full text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 shadow-sm"
                                           onclick="return confirm('Are you sure you want to delete this customer?');"
                                           title="Delete">
                                            <i class="ri-delete-bin-line"></i>
                                            <span class="ml-1 hidden sm:inline">Delete</span>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } else { %>
                <div class="text-center py-12">
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-gray-100 text-gray-400 mb-4">
                        <i class="ri-group-line text-2xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-1">No customers found</h3>
                    <p class="text-gray-500 mb-6">Get started by adding your first customer</p>
                    <a href="${pageContext.request.contextPath}/customer/add" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 transition-colors">
                        <i class="ri-user-add-line mr-2"></i> Add Customer
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </body>
</html>