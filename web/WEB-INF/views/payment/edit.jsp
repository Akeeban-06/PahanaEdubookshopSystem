<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.User" %>
<%@ page import="com.pahanaedu.model.Payment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Payment payment = (Payment) request.getAttribute("payment");
    String error = (String) request.getAttribute("error");
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Payment - Pahana Edu Bookshop</title>
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
        <!-- Breadcrumb -->
        <div class="flex items-center space-x-2 text-sm text-gray-500 mb-6">
            <a href="${pageContext.request.contextPath}/dashboard" class="hover:text-gray-700">Dashboard</a>
            <i class="ri-arrow-right-s-line"></i>
            <a href="${pageContext.request.contextPath}/payment/report" class="hover:text-gray-700">Payment Report</a>
            <i class="ri-arrow-right-s-line"></i>
            <span class="text-gray-900">Edit Payment</span>
        </div>

        <!-- Header -->
        <div class="flex items-center justify-between mb-6">
            <div>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-900">Edit Payment</h1>
                <p class="text-gray-500 mt-1">Update payment method and status</p>
            </div>
            <a href="${pageContext.request.contextPath}/payment/report" 
               class="inline-flex items-center px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-800 font-medium rounded-lg transition-colors duration-200">
                <i class="ri-arrow-left-line mr-2"></i>Back to Report
            </a>
        </div>

        <% if (payment == null) { %>
            <div class="bg-white rounded-lg shadow-md p-8 text-center">
                <i class="ri-error-warning-line text-6xl text-red-400 mb-4"></i>
                <h2 class="text-xl font-semibold text-gray-900 mb-2">Payment Not Found</h2>
                <p class="text-gray-500 mb-4">The requested payment record could not be found.</p>
                <a href="${pageContext.request.contextPath}/payment/report" 
                   class="inline-flex items-center px-4 py-2 bg-primary-600 hover:bg-primary-700 text-white font-medium rounded-lg transition-colors duration-200">
                    <i class="ri-arrow-left-line mr-2"></i>Return to Payment Report
                </a>
            </div>
        <% } else { %>
            <!-- Error Messages -->
            <% if (error != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-800 px-4 py-3 rounded-lg mb-6">
                    <div class="flex items-center">
                        <i class="ri-error-warning-line mr-2"></i>
                        <strong class="font-medium">Error!</strong>
                        <span class="ml-2"><%= error %></span>
                    </div>
                </div>
            <% } %>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Payment Information (Read-only) -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Payment Information</h3>
                        
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Payment ID</label>
                                <div class="text-sm text-gray-900 font-mono">#<%= payment.getPaymentId() %></div>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Bill ID</label>
                                <div class="text-sm text-gray-900 font-mono">#<%= payment.getBillId() %></div>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Customer</label>
                                <div class="text-sm text-gray-900">
                                    <%= payment.getCustomerName() != null ? payment.getCustomerName() : "N/A" %>
                                </div>
                                <div class="text-xs text-gray-500">
                                    <%= payment.getCustomerAccountNumber() != null ? payment.getCustomerAccountNumber() : "N/A" %>
                                </div>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Amount Paid</label>
                                <div class="text-lg font-semibold text-gray-900">
                                    LKR <%= String.format("%.2f", payment.getAmountPaid()) %>
                                </div>
                                <% if (payment.getBillTotalAmount() != null) { %>
                                    <div class="text-xs text-gray-500">
                                        of LKR <%= String.format("%.2f", payment.getBillTotalAmount()) %> total
                                    </div>
                                <% } %>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Payment Date</label>
                                <div class="text-sm text-gray-900">
                                    <%= payment.getPaymentDate() != null ? dateFormat.format(payment.getPaymentDate()) : "N/A" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Form -->
                <div class="lg:col-span-2">
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Editable Fields</h3>
                        
                        <form method="post" action="${pageContext.request.contextPath}/payment/update" class="space-y-6">
                            <input type="hidden" name="paymentId" value="<%= payment.getPaymentId() %>">
                            
                            <!-- Amount Paid -->
                            <div>
                                <label for="amountPaid" class="block text-sm font-medium text-gray-700 mb-2">
                                    Amount Paid (LKR) <span class="text-red-500">*</span>
                                </label>
                                <input type="number" 
                                       id="amountPaid" 
                                       name="amountPaid" 
                                       value="<%= payment.getAmountPaid() %>"
                                       step="0.01" 
                                       min="0.01" 
                                       max="999999.99"
                                       required 
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200">
                                <p class="mt-1 text-xs text-gray-500">Enter the amount that was actually paid for this transaction</p>
                                <% if (payment.getBillTotalAmount() != null) { %>
                                    <p class="mt-1 text-xs text-blue-600">
                                        <i class="ri-information-line mr-1"></i>Total bill amount: LKR <%= String.format("%.2f", payment.getBillTotalAmount()) %>
                                    </p>
                                <% } %>
                            </div>
                            
                            <!-- Payment Method -->
                            <div>
                                <label for="paymentMethod" class="block text-sm font-medium text-gray-700 mb-2">
                                    Payment Method <span class="text-red-500">*</span>
                                </label>
                                <select id="paymentMethod" name="paymentMethod" required 
                                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200">
                                    <option value="Cash" <%= "Cash".equals(payment.getPaymentMethod()) ? "selected" : "" %>>Cash</option>
                                    <option value="Card" <%= "Card".equals(payment.getPaymentMethod()) ? "selected" : "" %>>Card</option>
                                    <option value="Online" <%= "Online".equals(payment.getPaymentMethod()) ? "selected" : "" %>>Online</option>
                                </select>
                                <p class="mt-1 text-xs text-gray-500">Select the payment method used for this transaction</p>
                            </div>
                            
                            <!-- Payment Status -->
                            <div>
                                <label for="paymentStatus" class="block text-sm font-medium text-gray-700 mb-2">
                                    Payment Status <span class="text-red-500">*</span>
                                </label>
                                <select id="paymentStatus" name="paymentStatus" required 
                                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-primary-500 focus:border-primary-500 transition-colors duration-200">
                                    <option value="Successful" <%= "Successful".equals(payment.getPaymentStatus()) ? "selected" : "" %>>Successful</option>
                                    <option value="Failed" <%= "Failed".equals(payment.getPaymentStatus()) ? "selected" : "" %>>Failed</option>
                                    <option value="Pending" <%= "Pending".equals(payment.getPaymentStatus()) ? "selected" : "" %>>Pending</option>
                                </select>
                                <p class="mt-1 text-xs text-gray-500">Update the current status of this payment</p>
                            </div>
                            
                            <!-- Current Values Display -->
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <h4 class="text-sm font-medium text-blue-900 mb-2">Current Values</h4>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                                    <div>
                                        <span class="text-blue-700">Amount:</span> 
                                        <span class="font-medium text-blue-900">LKR <%= String.format("%.2f", payment.getAmountPaid()) %></span>
                                    </div>
                                    <div>
                                        <span class="text-blue-700">Method:</span> 
                                        <span class="font-medium text-blue-900"><%= payment.getPaymentMethod() %></span>
                                    </div>
                                    <div>
                                        <span class="text-blue-700">Status:</span> 
                                        <span class="font-medium text-blue-900"><%= payment.getPaymentStatus() %></span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Form Actions -->
                            <div class="flex flex-col sm:flex-row gap-3 pt-4">
                                <button type="submit" 
                                        class="flex-1 bg-primary-600 hover:bg-primary-700 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200 flex items-center justify-center">
                                    <i class="ri-save-line mr-2"></i>Update Payment
                                </button>
                                <a href="${pageContext.request.contextPath}/payment/report" 
                                   class="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-800 px-6 py-3 rounded-lg font-medium transition-colors duration-200 flex items-center justify-center">
                                    <i class="ri-close-line mr-2"></i>Cancel
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const amountPaid = document.getElementById('amountPaid').value;
            const paymentMethod = document.getElementById('paymentMethod').value;
            const paymentStatus = document.getElementById('paymentStatus').value;
            
            if (!amountPaid || !paymentMethod || !paymentStatus) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return false;
            }
            
            if (parseFloat(amountPaid) <= 0) {
                e.preventDefault();
                alert('Amount paid must be greater than zero.');
                return false;
            }
        });

        // Highlight changes
        const amountInput = document.getElementById('amountPaid');
        const methodSelect = document.getElementById('paymentMethod');
        const statusSelect = document.getElementById('paymentStatus');
        const originalAmount = '<%= payment != null ? payment.getAmountPaid() : "" %>';
        const originalMethod = '<%= payment != null ? payment.getPaymentMethod() : "" %>';
        const originalStatus = '<%= payment != null ? payment.getPaymentStatus() : "" %>';

        function highlightChanges() {
            const amountChanged = amountInput.value !== originalAmount;
            const methodChanged = methodSelect.value !== originalMethod;
            const statusChanged = statusSelect.value !== originalStatus;
            
            // Highlight amount field
            amountInput.classList.toggle('ring-2', amountChanged);
            amountInput.classList.toggle('ring-yellow-400', amountChanged);
            amountInput.classList.toggle('bg-yellow-50', amountChanged);
            
            // Highlight method field
            methodSelect.classList.toggle('ring-2', methodChanged);
            methodSelect.classList.toggle('ring-yellow-400', methodChanged);
            methodSelect.classList.toggle('bg-yellow-50', methodChanged);
            
            // Highlight status field
            statusSelect.classList.toggle('ring-2', statusChanged);
            statusSelect.classList.toggle('ring-yellow-400', statusChanged);
            statusSelect.classList.toggle('bg-yellow-50', statusChanged);
        }

        amountInput.addEventListener('input', highlightChanges);
        methodSelect.addEventListener('change', highlightChanges);
        statusSelect.addEventListener('change', highlightChanges);
        
        // Format amount input on blur
        amountInput.addEventListener('blur', function() {
            const value = parseFloat(this.value);
            if (!isNaN(value)) {
                this.value = value.toFixed(2);
            }
        });
    </script>
</body>
</html>