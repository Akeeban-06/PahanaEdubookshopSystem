<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    Customer customer = (Customer) request.getAttribute("customer");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bills for <%= customer.getName() %> - Pahana Edu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <i class="fas fa-book-open me-2"></i>Pahana Edu Bookshop
            </a>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header">
                <h4>
                    <i class="fas fa-receipt me-2"></i>
                    Bills for <%= customer.getName() %> (<%= customer.getAccountNumber() %>)
                </h4>
            </div>
            <div class="card-body">
                <% if (bills.isEmpty()) { %>
                    <div class="alert alert-info">
                        No bills found for this customer.
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Bill #</th>
                                    <th>Date</th>
                                    <th class="text-end">Amount (Rs.)</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Bill bill : bills) { %>
                                    <tr>
                                        <td><%= String.format("INV-%05d", bill.getBillId()) %></td>
                                        <td><%= dateFormat.format(bill.getBillDate()) %></td>
                                        <td class="text-end"><%= String.format("%,.2f", bill.getTotalAmount()) %></td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/bill/view?billId=<%= bill.getBillId() %>" 
                                               class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <a href="${pageContext.request.contextPath}/bill/print?billId=<%= bill.getBillId() %>" 
                                               class="btn btn-sm btn-secondary">
                                                <i class="fas fa-print"></i> Print
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>