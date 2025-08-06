<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.User" %>
<%@ page import="com.pahanaedu.model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Check if user is admin - redirect if not
    if (!"admin".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/dashboard?error=access_denied");
        return;
    }
    
    List<Payment> payments = (List<Payment>) request.getAttribute("payments");
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
    String errorParam = request.getParameter("error");
    String filterDescription = (String) request.getAttribute("filterDescription");
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm");
    SimpleDateFormat dateInputFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Report - Pahana Edu Bookshop</title>
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
        body { font-family: 'Inter', sans-serif; }
        .nav-gradient { background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%); }
        .status-successful { background-color: #dcfce7; color: #166534; }
        .status-failed { background-color: #fee2e2; color: #991b1b; }
        .status-pending { background-color: #fef3c7; color: #92400e; }
        .method-cash { background-color: #f0fdf4; color: #166534; }
        .method-card { background-color: #eff6ff; color: #1d4ed8; }
        .method-online { background-color: #f5f3ff; color: #7c3aed; }
      
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
                        <div class="flex flex-col">
                            <span class="font-medium"><%= currentUser.getUsername() %></span>
                          
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
        <!-- Breadcrumb -->
        <div class="flex items-center space-x-2 text-sm text-gray-500 mb-6">
            <a href="${pageContext.request.contextPath}/dashboard" class="hover:text-gray-700">Dashboard</a>
            <i class="ri-arrow-right-s-line"></i>
            <span class="text-gray-900">Payment Report</span>
        </div>

        <!-- Header -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6">
            <div>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-900">Payment Report</h1>
                <p class="text-gray-500 mt-1">View and manage payment records - Administrator access required</p>
            </div>
        </div>

        <!-- Messages -->
        <% if (success != null) { %>
            <div id="successMsg" class="bg-green-100 border border-green-400 text-green-800 px-4 py-3 rounded-lg mb-6 transition-opacity duration-500">
                <div class="flex items-center">
                    <i class="ri-check-circle-line mr-2"></i>
                    <strong class="font-medium">Success!</strong>
                    <span class="ml-2">
                        <% if ("payment_updated".equals(success)) { %>
                            Payment has been updated successfully.
                        <% } %>
                    </span>
                </div>
            </div>
        <% } %>

        <% if (error != null || errorParam != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-800 px-4 py-3 rounded-lg mb-6">
                <div class="flex items-center">
                    <i class="ri-error-warning-line mr-2"></i>
                    <strong class="font-medium">Error!</strong>
                    <span class="ml-2">
                        <% if (error != null) { %>
                            <%= error %>
                        <% } else if ("invalid_id".equals(errorParam)) { %>
                            Invalid payment ID provided.
                        <% } else if ("payment_not_found".equals(errorParam)) { %>
                            Payment record not found.
                        <% } else if ("system_error".equals(errorParam)) { %>
                            System error occurred. Please try again.
                        <% } %>
                    </span>
                </div>
            </div>
        <% } %>

        <!-- Payment Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h3 class="text-lg font-semibold text-gray-900">Payment Records</h3>
                <% if (payments != null) { %>
                    <p class="text-sm text-gray-500">Showing <%= payments.size() %> payment(s)</p>
                <% } %>
            </div>
            
            <% if (payments == null || payments.isEmpty()) { %>
                <div class="text-center py-12">
                    <i class="ri-file-list-3-line text-6xl text-gray-300 mb-4"></i>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">No Payments Found</h3>
                    <p class="text-gray-500">There are no payment records to display.</p>
                </div>
            <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Bill ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Customer</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Method</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% for (Payment payment : payments) { %>
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                        <%= payment.getPaymentId() %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <%= payment.getBillId() %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">
                                            <%= payment.getCustomerName() != null ? payment.getCustomerName() : "N/A" %>
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            <%= payment.getCustomerAccountNumber() != null ? payment.getCustomerAccountNumber() : "N/A" %>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <div class="font-medium">LKR <%= String.format("%.2f", payment.getAmountPaid()) %></div>
                                        <% if (payment.getBillTotalAmount() != null) { %>
                                            <div class="text-xs text-gray-500">of LKR <%= String.format("%.2f", payment.getBillTotalAmount()) %></div>
                                        <% } %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 py-1 text-xs font-medium rounded-full 
                                            <% if ("Cash".equals(payment.getPaymentMethod())) { %>method-cash<% } 
                                               else if ("Card".equals(payment.getPaymentMethod())) { %>method-card<% } 
                                               else if ("Online".equals(payment.getPaymentMethod())) { %>method-online<% } %>">
                                            <%= payment.getPaymentMethod() %>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 py-1 text-xs font-medium rounded-full 
                                            <% if ("Successful".equals(payment.getPaymentStatus())) { %>status-successful<% } 
                                               else if ("Failed".equals(payment.getPaymentStatus())) { %>status-failed<% } 
                                               else if ("Pending".equals(payment.getPaymentStatus())) { %>status-pending<% } %>">
                                            <%= payment.getPaymentStatus() %>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <%= payment.getPaymentDate() != null ? dateFormat.format(payment.getPaymentDate()) : "N/A" %>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <a href="${pageContext.request.contextPath}/payment/edit?id=<%= payment.getPaymentId() %>" 
                                           class="inline-flex items-center px-3 py-1 bg-blue-100 hover:bg-blue-200 text-blue-800 text-sm font-medium rounded-lg transition-colors duration-200">
                                            <i class="ri-edit-line mr-1"></i>Edit
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        // Auto-hide success messages
        setTimeout(function() {
            const successMsg = document.getElementById('successMsg');
            if (successMsg) {
                successMsg.classList.add('opacity-0');
                setTimeout(() => successMsg.remove(), 500);
            }
        }, 5000);
    </script>
</body>
</html>