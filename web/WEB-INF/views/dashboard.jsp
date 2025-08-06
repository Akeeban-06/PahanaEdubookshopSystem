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
        <title>Dashboard - Pahana Edu Bookshop</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: {
                                50: '#f0f9ff',
                                100: '#e0f2fe',
                                200: '#bae6fd',
                                300: '#7dd3fc',
                                400: '#38bdf8',
                                500: '#0ea5e9',
                                600: '#0284c7',
                                700: '#0369a1',
                                800: '#075985',
                                900: '#0c4a6e',
                            }
                        },
                        fontFamily: {
                            sans: ['Inter', 'sans-serif'],
                        },
                    }
                }
            }
        </script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

            body {
                font-family: 'Inter', sans-serif;
            }

            .dashboard-card {
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                background: linear-gradient(135deg, rgba(255,255,255,0.9) 0%, rgba(255,255,255,0.95) 100%);
                backdrop-filter: blur(10px);
            }

            .dashboard-card:hover {
                transform: translateY(-5px) scale(1.02);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            }

            .nav-gradient {
                background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
            }

            .icon-container {
                transition: all 0.3s ease;
            }

            .dashboard-card:hover .icon-container {
                transform: scale(1.1);
            }

            .admin-badge {
/*              background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);*/
              color: white;
              font-size: large;
              padding: 2px 8px;
              font-family: Inter;
            }
            
             .admin-badge1 {
              background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
              color: white;
              font-size: 0.75rem;
              padding: 2px 8px;
              border-radius: 12px;
              font-weight: 600;
            }

            .staff-badge {
/*                background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);*/
                color: white;
                font-size: large;
                padding: 2px 8px;
                font-family: Inter;
               
            }
        </style>
    </head>
    <body class="bg-gray-50 min-h-screen">
        <!-- Navigation -->
        <nav class="nav-gradient text-white shadow-lg">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-20 items-center">
                    <div class="flex items-center space-x-3">
                        <div class="flex items-center justify-center w-10 h-10 rounded-lg bg-white/20">
                            <i class="ri-book-open-line text-xl"></i>
                        </div>
                        <a href="#" class="flex items-center space-x-2">
                            <span class="font-bold text-xl tracking-tight">Pahana Edu Bookshop</span>
                        </a>
                    </div>
                    <div class="flex items-center space-x-6">
                        <div class="hidden md:flex items-center space-x-2 bg-white/10 px-4 py-2 rounded-full">
                            <div class="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center">
                                <i class="ri-user-line"></i>
                            </div>
                            <div class="flex flex-col">
                                <span class="<%= "admin".equals(currentUser.getRole()) ? "admin-badge" : "staff-badge" %>">
                                    <%= currentUser.getRole() %>
                                </span>
                            </div>
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
            <!-- Header with greeting -->
            <div class="mb-8">
                <h1 class="text-3xl md:text-4xl font-bold text-gray-800">Welcome, <span class="text-primary-600"><%= currentUser.getUsername() %></span></h1>
                <p class="text-gray-500 mt-2">Here's what's happening with your store</p>
            </div>

            <!-- Access Denied Message -->
            <% String errorParam = request.getParameter("error"); %>
            <% if ("access_denied".equals(errorParam)) { %>
                <div id="accessDeniedMsg" class="bg-red-100 border border-red-400 text-red-800 px-4 py-3 rounded-lg mb-6 transition-opacity duration-500">
                    <div class="flex items-center">
                        <i class="ri-error-warning-line mr-2"></i>
                        <strong class="font-medium">Access Denied!</strong>
                        <span class="ml-2">You don't have permission to access that resource. Only administrators can view payment reports.</span>
                    </div>
                </div>
            <% } %>

            <!-- Quick Actions -->
            <div class="mb-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Quick Actions</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-<%= "admin".equals(currentUser.getRole()) ? "5" : "4" %> gap-6">
                    <!-- Customer Management -->
                    <a href="${pageContext.request.contextPath}/customer/" class="dashboard-card rounded-xl shadow-md overflow-hidden border border-gray-100">
                        <div class="p-6 text-center">
                            <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-blue-100 text-blue-600 mb-4 icon-container">
                                <i class="ri-group-line text-3xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Customer Management</h3>
                            <p class="text-gray-500 text-sm mb-4">Add, edit, and manage customer accounts</p>
                            <div class="text-blue-600 text-sm font-medium flex items-center justify-center">
                                Go to customers <i class="ri-arrow-right-line ml-1"></i>
                            </div>
                        </div>
                    </a>

                    <!-- Item Management -->
                    <a href="${pageContext.request.contextPath}/item/" class="dashboard-card rounded-xl shadow-md overflow-hidden border border-gray-100">
                        <div class="p-6 text-center">
                            <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 text-green-600 mb-4 icon-container">
                                <i class="ri-book-open-line text-3xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Item Management</h3>
                            <p class="text-gray-500 text-sm mb-4">Manage books, stationery and inventory</p>
                            <div class="text-green-600 text-sm font-medium flex items-center justify-center">
                                Go to items <i class="ri-arrow-right-line ml-1"></i>
                            </div>
                        </div>
                    </a>

                    <!-- Billing -->
                    <a href="${pageContext.request.contextPath}/bill/create" class="dashboard-card rounded-xl shadow-md overflow-hidden border border-gray-100">
                        <div class="p-6 text-center">
                            <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-yellow-100 text-yellow-600 mb-4 icon-container">
                                <i class="ri-bill-line text-3xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Billing System</h3>
                            <p class="text-gray-500 text-sm mb-4">Create bills and manage transactions</p>
                            <div class="text-yellow-600 text-sm font-medium flex items-center justify-center">
                                Create bill <i class="ri-arrow-right-line ml-1"></i>
                            </div>
                        </div>
                    </a>

                    <!-- Payment Report - ADMIN ONLY -->
                    <% if ("admin".equals(currentUser.getRole())) { %>
                        <a href="${pageContext.request.contextPath}/payment/report" class="dashboard-card rounded-xl shadow-md overflow-hidden border border-gray-100">
                            <div class="p-6 text-center">
                                <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-purple-100 text-purple-600 mb-4 icon-container">
                                    <i class="ri-file-chart-line text-3xl"></i>
                                </div>
                                <h3 class="text-lg font-semibold text-gray-900 mb-2">Payment Report</h3>
                                <p class="text-gray-500 text-sm mb-4">View and manage payment records</p>
                                <div class="text-purple-600 text-sm font-medium flex items-center justify-center">
                                    View payments <i class="ri-arrow-right-line ml-1"></i>
                                </div>
                                <div class="mt-2">
                                    <span class="admin-badge1">Admin Only</span>
                                </div>
                            </div>
                        </a>
                    <% } %>

                    <!-- Help -->
                    <a href="${pageContext.request.contextPath}/help" class="dashboard-card rounded-xl shadow-md overflow-hidden border border-gray-100">
                        <div class="p-6 text-center">
                            <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-red-100 text-red-600 mb-4 icon-container">
                                <i class="ri-question-line text-3xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Help & Support</h3>
                            <p class="text-gray-500 text-sm mb-4">System usage guidelines and support</p>
                            <div class="text-red-600 text-sm font-medium flex items-center justify-center">
                                Get help <i class="ri-arrow-right-line ml-1"></i>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Staff Notice for Payment Report Access -->

        </div>
    </div>

    <script>
        // Auto-hide error messages
        setTimeout(function() {
            const errorMsg = document.getElementById('accessDeniedMsg');
            if (errorMsg) {
                errorMsg.classList.add('opacity-0');
                setTimeout(() => errorMsg.remove(), 500);
            }
        }, 5000);
    </script>
</body>
</html>

<% String successMessage = (String) request.getAttribute("loginSuccess"); %>
<% if (successMessage != null) { %>
<div id="loginSuccessMsg" class="bg-green-100 border border-green-400 text-green-800 px-4 py-3 rounded relative shadow-md mb-4 transition-opacity duration-500 ease-in-out">
    <strong class="font-bold">Success! </strong>
    <span class="block sm:inline"><%= successMessage %></span>
</div>

<script>
    // Auto-hide the message after 3 seconds
    setTimeout(function () {
        const msg = document.getElementById("loginSuccessMsg");
        if (msg) {
            msg.classList.add("opacity-0");
            setTimeout(() => msg.remove(), 500); // remove after fade-out
        }
    }, 3000);
</script>
<% } %>