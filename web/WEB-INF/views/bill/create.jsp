<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
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
    <title>Create Bill - Pahana Edu Bookshop</title>
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
        
        .item-row {
            transition: all 0.2s ease;
        }
        
        .item-row:hover {
            background-color: #f8fafc;
        }
        
        .input-focus:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.2);
        }
        
        /* Payment method styles */
        .payment-option {
            transition: all 0.2s ease;
        }
        
        .payment-option:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .payment-option input[type="radio"]:checked + .payment-content {
            border-color: #0ea5e9;
            background-color: #eff6ff;
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

    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="bill-card bg-white rounded-xl overflow-hidden border border-gray-200">
            <!-- Card Header -->
            <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-blue-50 to-blue-100">
                <div class="flex items-center">
                    <div class="flex-shrink-0 bg-blue-600 text-white p-3 rounded-lg">
                        <i class="ri-bill-line text-2xl"></i>
                    </div>
                    <div class="ml-4">
                        <h2 class="text-2xl font-bold text-gray-800">Create New Bill</h2>
                        <p class="text-gray-600">Generate a new invoice for your customer</p>
                    </div>
                </div>
            </div>
            
            <!-- Card Body -->
            <div class="px-6 py-6">
                <form method="post" action="${pageContext.request.contextPath}/bill/create" class="space-y-6">
                    <!-- Customer Selection -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="customerId" class="block text-sm font-medium text-gray-700 mb-1">
                                Select Customer <span class="text-red-500">*</span>
                            </label>
                            <div class="relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="ri-user-line text-gray-400"></i>
                                </div>
                                <select id="customerId" name="customerId" required
                                        class="input-focus block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                    <option value="">Choose a customer...</option>
                                    <% if (customers != null) {
                                        for (Customer customer : customers) { %>
                                            <option value="<%= customer.getCustomerId() %>">
                                                <%= customer.getAccountNumber() %> - <%= customer.getName() %>
                                            </option>
                                    <% }
                                    } %>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Items Section -->
                    <div class="space-y-4">
                        <h3 class="text-lg font-medium text-gray-800 flex items-center">
                            <i class="ri-shopping-cart-line text-blue-500 mr-2"></i> Bill Items
                        </h3>
                        
                        <div id="itemsContainer" class="space-y-4">
                            <div class="item-row bg-gray-50 p-4 rounded-lg border border-gray-200">
                                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                                    <!-- Item Selection -->
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Item</label>
                                        <select class="item-select input-focus block w-full pl-3 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                                name="itemId" onchange="updatePrice(this)">
                                            <option value="">Choose an item...</option>
                                            <% if (items != null) {
                                                for (Item item : items) { %>
                                                    <option value="<%= item.getItemId() %>" 
                                                            data-price="<%= item.getPrice() %>" 
                                                            data-stock="<%= item.getStock() %>">
                                                        <%= item.getItemName() %> (Stock: <%= item.getStock() %>) - Rs. <%= item.getPrice() %>
                                                    </option>
                                            <% }
                                            } %>
                                        </select>
                                    </div>
                                    
                                    <!-- Quantity -->
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Quantity</label>
                                        <input type="number" class="quantity-input input-focus block w-full pl-3 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                                               name="quantity" min="1" value="1" onchange="calculateSubtotal(this)">
                                    </div>
                                    
                                    <!-- Subtotal -->
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Subtotal</label>
                                        <input type="text" class="subtotal input-focus block w-full pl-3 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm bg-gray-100"
                                               readonly value="Rs. 0.00">
                                    </div>
                                    
                                    <!-- Remove Button -->
                                    <div class="flex items-end">
                                        <button type="button" class="remove-btn h-10 w-full inline-flex justify-center items-center px-3 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors"
                                                onclick="removeItem(this)">
                                            <i class="ri-delete-bin-line"></i>
                                            <span class="ml-1 hidden sm:inline">Remove</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Add Item Button -->
                        <div>
                            <button type="button" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors"
                                    onclick="addItem()">
                                <i class="ri-add-line mr-2"></i> Add Another Item
                            </button>
                        </div>
                    </div>
                    
                    <!-- Payment Method Selection -->
                    <div class="space-y-4">
                        <h3 class="text-lg font-medium text-gray-800 flex items-center">
                            <i class="ri-money-dollar-circle-line text-green-500 mr-2"></i> Payment Method
                        </h3>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Cash Payment -->
                            <label class="payment-option cursor-pointer">
                                <input type="radio" name="paymentMethod" value="Cash" class="sr-only" checked>
                                <div class="payment-content border-2 border-gray-200 rounded-lg p-4 bg-white">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0">
                                            <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center">
                                                <i class="ri-money-dollar-box-line text-green-600 text-xl"></i>
                                            </div>
                                        </div>
                                        <div class="ml-3">
                                            <h4 class="text-sm font-medium text-gray-900">Cash Payment</h4>
                                            <p class="text-sm text-gray-500">Direct cash payment</p>
                                        </div>
                                    </div>
                                </div>
                            </label>
                            
                            <!-- Card Payment -->
                            <label class="payment-option cursor-pointer">
                                <input type="radio" name="paymentMethod" value="Card" class="sr-only">
                                <div class="payment-content border-2 border-gray-200 rounded-lg p-4 bg-white">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0">
                                            <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
                                                <i class="ri-bank-card-line text-blue-600 text-xl"></i>
                                            </div>
                                        </div>
                                        <div class="ml-3">
                                            <h4 class="text-sm font-medium text-gray-900">Card Payment</h4>
                                            <p class="text-sm text-gray-500">Credit/Debit card payment</p>
                                        </div>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>
                    
                    <!-- Total Section -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div></div> <!-- Empty column for alignment -->
                        <div class="bg-blue-50 p-4 rounded-lg border border-blue-200">
                            <div class="flex justify-between items-center">
                                <h3 class="text-lg font-bold text-gray-800">Total Amount:</h3>
                                <h3 class="text-2xl font-bold text-blue-600" id="totalAmount">Rs. 0.00</h3>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="flex flex-col-reverse sm:flex-row sm:justify-between sm:space-x-3 space-y-3 sm:space-y-0 pt-4 border-t border-gray-200">
                        <a href="${pageContext.request.contextPath}/dashboard" 
                           class="inline-flex justify-center items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                            <i class="ri-arrow-left-line mr-2"></i> Back to Dashboard
                        </a>
                        <button type="submit" 
                                class="inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                            <i class="ri-save-line mr-2"></i> Create Bill
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Payment method selection
        document.querySelectorAll('input[name="paymentMethod"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                // Remove selected state from all options
                document.querySelectorAll('.payment-content').forEach(function(content) {
                    content.classList.remove('border-blue-500', 'bg-blue-50');
                    content.classList.add('border-gray-200', 'bg-white');
                });
                
                // Add selected state to chosen option
                if (this.checked) {
                    const content = this.nextElementSibling;
                    content.classList.remove('border-gray-200', 'bg-white');
                    content.classList.add('border-blue-500', 'bg-blue-50');
                }
            });
        });
        
        // Initialize default selection
        document.addEventListener('DOMContentLoaded', function() {
            const defaultRadio = document.querySelector('input[name="paymentMethod"]:checked');
            if (defaultRadio) {
                defaultRadio.dispatchEvent(new Event('change'));
            }
        });

        function addItem() {
            const container = document.getElementById('itemsContainer');
            const newRow = container.querySelector('.item-row').cloneNode(true);
            
            // Reset values
            newRow.querySelector('.item-select').value = '';
            newRow.querySelector('.quantity-input').value = '1';
            newRow.querySelector('.subtotal').value = 'Rs. 0.00';
            
            container.appendChild(newRow);
        }

        function removeItem(button) {
            const container = document.getElementById('itemsContainer');
            if (container.children.length > 1) {
                button.closest('.item-row').remove();
                calculateTotal();
            }
        }

        function updatePrice(select) {
            const row = select.closest('.item-row');
            const quantityInput = row.querySelector('.quantity-input');
            const subtotalInput = row.querySelector('.subtotal');
            
            if (select.value) {
                const selectedOption = select.options[select.selectedIndex];
                const stock = parseInt(selectedOption.dataset.stock);
                quantityInput.max = stock;
                
                if (parseInt(quantityInput.value) > stock) {
                    quantityInput.value = stock;
                }
                
                calculateSubtotal(quantityInput);
            } else {
                subtotalInput.value = 'Rs. 0.00';
                calculateTotal();
            }
        }

        function calculateSubtotal(quantityInput) {
            const row = quantityInput.closest('.item-row');
            const select = row.querySelector('.item-select');
            const subtotalInput = row.querySelector('.subtotal');
            
            if (select.value && quantityInput.value) {
                const selectedOption = select.options[select.selectedIndex];
                const price = parseFloat(selectedOption.dataset.price);
                const quantity = parseInt(quantityInput.value);
                const subtotal = price * quantity;
                
                subtotalInput.value = 'Rs. ' + subtotal.toFixed(2);
            } else {
                subtotalInput.value = 'Rs. 0.00';
            }
            
            calculateTotal();
        }

        function calculateTotal() {
            let total = 0;
            const subtotals = document.querySelectorAll('.subtotal');
            
            subtotals.forEach(function(subtotalInput) {
                const value = subtotalInput.value.replace('Rs. ', '');
                if (value && !isNaN(value)) {
                    total += parseFloat(value);
                }
            });
            
            document.getElementById('totalAmount').textContent = 'Rs. ' + total.toFixed(2);
        }
    </script>
</body>
</html>