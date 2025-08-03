<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    Customer customer = (Customer) request.getAttribute("customer");
    boolean printMode = request.getAttribute("printMode") != null;
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill #<%= bill.getBillId() %> - Pahana Edu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <% if (printMode) { %>
        <style>
            body { font-family: Arial, sans-serif; font-size: 12pt; }
            .header { text-align: center; margin-bottom: 20px; }
            .company-name { font-size: 18pt; font-weight: bold; }
            .receipt-title { font-size: 16pt; margin: 10px 0; }
            table { width: 100%; border-collapse: collapse; margin: 15px 0; }
            th, td { padding: 8px; border: 1px solid #ddd; text-align: left; }
            th { background-color: #f2f2f2; }
            .text-right { text-align: right; }
            .text-center { text-align: center; }
            .footer { margin-top: 30px; font-size: 10pt; text-align: center; }
            .no-print { display: none; }
        </style>
    <% } else { %>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            @media print {
                .no-print { display: none !important; }
                body { background-color: white !important; }
                .receipt-header { border-bottom: 2px dashed #dee2e6; }
            }
            .receipt-header { padding-bottom: 20px; margin-bottom: 20px; }
        </style>
    <% } %>
</head>
<body class="<%= printMode ? "" : "bg-light" %>">
    <% if (!printMode) { %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary no-print">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                    <i class="fas fa-book-open me-2"></i>Pahana Edu Bookshop
                </a>
                <div class="navbar-nav ms-auto">
                    <button onclick="window.print()" class="btn btn-outline-light btn-sm me-2">
                        <i class="fas fa-print"></i> Print
                    </button>
                    <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </div>
            </div>
        </nav>
    <% } %>

    <div class="<%= printMode ? "container-fluid p-4" : "container mt-4" %>">
        <% if (bill == null) { %>
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i> Bill not found with the specified ID.
            </div>
        <% } else { %>
            <!-- Header -->
            <div class="<%= printMode ? "header" : "receipt-header text-center" %>">
                <div class="<%= printMode ? "company-name" : "text-primary h2" %>">Pahana Edu Bookshop</div>
                <div class="text-muted">123 Book Street, Colombo 05</div>
                <div class="text-muted">Tel: 011-1234567 | Email: info@pahanaedu.lk</div>
                <div class="<%= printMode ? "receipt-title" : "h4 mt-3" %>">TAX INVOICE</div>
            </div>

            <!-- Bill Info -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <strong>Invoice #:</strong> <%= String.format("INV-%05d", bill.getBillId()) %><br>
                    <strong>Date:</strong> <%= dateFormat.format(bill.getBillDate()) %><br>
                    <strong>Customer ID:</strong> <%= customer.getCustomerId() %>
                </div>
                <div class="col-md-6 text-md-end">
                    <strong>Customer:</strong> <%= customer.getName() %><br>
                    <strong>Account #:</strong> <%= customer.getAccountNumber() %><br>
                    <% if (customer.getPhone() != null && !customer.getPhone().isEmpty()) { %>
                        <strong>Phone:</strong> <%= customer.getPhone() %><br>
                    <% } %>
                    <% if (customer.getEmail() != null && !customer.getEmail().isEmpty()) { %>
                        <strong>Email:</strong> <%= customer.getEmail() %>
                    <% } %>
                </div>
            </div>

            <!-- Items Table -->
            <div class="table-responsive">
                <table class="<%= printMode ? "" : "table table-bordered" %>">
                    <thead class="<%= printMode ? "" : "table-dark" %>">
                        <tr>
                            <th>#</th>
                            <th>Item Description</th>
                            <th class="text-end">Unit Price (Rs.)</th>
                            <th class="text-center">Qty</th>
                            <th class="text-end">Amount (Rs.)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        int itemCount = 1;
                        BigDecimal grandTotal = BigDecimal.ZERO;
                        for (BillItem item : bill.getBillItems()) { 
                            BigDecimal subtotal = item.getSubtotal();
                            grandTotal = grandTotal.add(subtotal);
                        %>
                            <tr>
                                <td><%= itemCount++ %></td>
                                <td><%= item.getItemName() %></td>
                                <td class="text-end"><%= String.format("%,.2f", item.getPrice()) %></td>
                                <td class="text-center"><%= item.getQuantity() %></td>
                                <td class="text-end"><%= String.format("%,.2f", subtotal) %></td>
                            </tr>
                        <% } %>
                    </tbody>
                    <tfoot class="<%= printMode ? "" : "table-light" %>">
                        <tr>
                            <th colspan="4" class="text-end">Total Amount:</th>
                            <th class="text-end">Rs. <%= String.format("%,.2f", bill.getTotalAmount()) %></th>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <!-- Footer -->
            <div class="<%= printMode ? "footer" : "text-center mt-4" %>">
                <p>Thank you for your business!</p>
                <small class="text-muted">This is a computer generated receipt. No signature required.</small>
            </div>
        <% } %>

        <% if (!printMode) { %>
            <div class="no-print mt-3">
                <a href="${pageContext.request.contextPath}/bill/customer?customerId=<%= customer.getCustomerId() %>" 
                   class="btn btn-info">
                    <i class="fas fa-list"></i> View All Bills for This Customer
                </a>
            </div>
        <% } %>
    </div>

    <% if (!printMode) { %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    <% } %>
</body>
</html>