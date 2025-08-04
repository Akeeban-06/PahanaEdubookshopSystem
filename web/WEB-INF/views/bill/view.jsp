<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    Customer customer = (Customer) request.getAttribute("customer");
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Details - Pahana Edu Bookshop</title>
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
        
        .bill-card {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .invoice-header {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        }
        
        @media print {
            .no-print { display: none !important; }
            body { background-color: white !important; }
            .bill-card { box-shadow: none !important; border: none !important; }
            .invoice-header { background: transparent !important; }
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
    <!-- Success Message -->
    <% String success = request.getParameter("success");
       if (success != null) { %>
        <div class="toast no-print">
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
    <% } %>

    <!-- Navigation -->
    <nav class="nav-gradient text-white shadow-lg no-print">
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
        <div class="bill-card bg-white rounded-xl overflow-hidden border border-gray-200">
            <!-- Invoice Header -->
            <div class="invoice-header px-6 py-8 border-b border-gray-200">
                <div class="flex flex-col items-center">
                    <div class="flex items-center justify-center w-16 h-16 rounded-full bg-blue-600 text-white mb-4">
                        <i class="ri-bill-line text-2xl"></i>
                    </div>
                    <h1 class="text-2xl font-bold text-blue-600">INVOICE</h1>
                    <p class="text-gray-500">Pahana Edu Bookshop</p>
                </div>
            </div>
            
            <!-- Invoice Body -->
            <div class="px-6 py-6">
                <% if (bill != null && customer != null) { %>
                    <!-- Bill Info -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                        <div>
                            <h3 class="text-lg font-semibold text-gray-800 mb-2">Bill Information</h3>
                            <div class="space-y-1">
                                <p><span class="font-medium">Invoice #:</span> <%= bill.getBillId() %></p>
                                <p><span class="font-medium">Date:</span> <%= dateFormat.format(bill.getBillDate()) %></p>
                                <p><span class="font-medium">Status:</span> 
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                        Paid
                                    </span>
                                </p>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-lg font-semibold text-gray-800 mb-2">Customer Information</h3>
                            <div class="space-y-1">
                                <p><span class="font-medium">Name:</span> <%= customer.getName() %></p>
                                <p><span class="font-medium">Account #:</span> <%= customer.getAccountNumber() %></p>
                                <p><span class="font-medium">Phone:</span> <%= customer.getPhone() != null ? customer.getPhone() : "N/A" %></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Items Table -->
                    <div class="overflow-x-auto mb-8">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">#</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Item Description</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                                    <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Qty</th>
                                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <% 
                                int itemCount = 1;
                                BigDecimal grandTotal = BigDecimal.ZERO;
                                
                                if (bill.getBillItems() != null && !bill.getBillItems().isEmpty()) {
                                    for (BillItem item : bill.getBillItems()) { 
                                        BigDecimal subtotal = item.getSubtotal();
                                        grandTotal = grandTotal.add(subtotal);
                                %>
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= itemCount++ %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= item.getItemName() != null ? item.getItemName() : "Unknown Item" %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-right">Rs. <%= item.getPrice() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center"><%= item.getQuantity() %></td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-right">Rs. <%= subtotal %></td>
                                    </tr>
                                <% }
                                } else { %>
                                    <tr>
                                        <td colspan="5" class="px-6 py-4 text-center text-sm text-gray-500">
                                            <i class="ri-error-warning-line"></i> No items found for this bill
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Total Section -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div></div>
                        <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                            <div class="space-y-2">
                                <div class="flex justify-between">
                                    <span class="font-medium">Subtotal:</span>
                                    <span>Rs. <%= bill.getTotalAmount() %></span>
                                </div>
                                <div class="flex justify-between border-t border-gray-200 pt-2">
                                    <span class="font-bold">Total Amount:</span>
                                    <span class="font-bold text-blue-600">Rs. <%= bill.getTotalAmount() %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Footer -->
                    <div class="mt-8 pt-4 border-t border-gray-200 text-center">
                        <p class="text-gray-500">Thank you for your business!</p>
                        <p class="text-xs text-gray-400 mt-2">This is a computer generated invoice.</p>
                    </div>
                <% } else { %>
                    <div class="text-center py-8">
                        <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-yellow-100 text-yellow-600 mb-4">
                            <i class="ri-error-warning-line text-2xl"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">
                            <% if (bill == null) { %>
                                Bill not found
                            <% } else if (customer == null) { %>
                                Customer information not available
                            <% } else { %>
                                Bill information incomplete
                            <% } %>
                        </h3>
                        <p class="text-gray-500 mb-6">Unable to display the requested bill details.</p>
                    </div>
                <% } %>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="flex flex-col-reverse sm:flex-row sm:justify-between sm:space-x-3 space-y-3 sm:space-y-0 mt-6 no-print">
            <a href="${pageContext.request.contextPath}/dashboard" 
               class="inline-flex justify-center items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                <i class="ri-arrow-left-line mr-2"></i> Back to Dashboard
            </a>
            <div class="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-3">
                <button onclick="window.print()" 
                        class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                    <i class="ri-printer-line mr-2"></i> Print Invoice
                </button>
                <a href="${pageContext.request.contextPath}/bill/create" 
                   class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors">
                    <i class="ri-add-line mr-2"></i> Create New Bill
                </a>
            </div>
        </div>
    </div>
</body>
</html>