package com.pahanaedu.servlet;

import com.pahanaedu.dao.PaymentDAO;
import com.pahanaedu.model.Payment;
import com.pahanaedu.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment/*"})
public class PaymentServlet extends HttpServlet {
    
    private PaymentDAO paymentDAO;
    
    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String action = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "report";
        
        switch (action) {
            case "report":
                showPaymentReport(request, response);
                break;
            case "edit":
                showEditPayment(request, response);
                break;
            default:
                showPaymentReport(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String action = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";
        
        switch (action) {
            case "update":
                updatePayment(request, response);
                break;
            case "filter":
                filterPayments(request, response);
                break;
            default:
                showPaymentReport(request, response);
                break;
        }
    }
    
    private void showPaymentReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<Payment> payments = paymentDAO.getAllPayments();
            request.setAttribute("payments", payments);
            request.setAttribute("pageTitle", "Payment Report");
            request.getRequestDispatcher("/WEB-INF/views/payment/report.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error showing payment report: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load payment report. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/payment/report.jsp").forward(request, response);
        }
    }
    
    private void showEditPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String paymentIdStr = request.getParameter("id");
            if (paymentIdStr == null || paymentIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/payment/report?error=invalid_id");
                return;
            }
            
            int paymentId = Integer.parseInt(paymentIdStr);
            Payment payment = paymentDAO.getPaymentById(paymentId);
            
            if (payment == null) {
                response.sendRedirect(request.getContextPath() + "/payment/report?error=payment_not_found");
                return;
            }
            
            request.setAttribute("payment", payment);
            request.setAttribute("pageTitle", "Edit Payment");
            request.getRequestDispatcher("/WEB-INF/views/payment/edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/payment/report?error=invalid_id");
        } catch (Exception e) {
            System.err.println("Error showing edit payment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payment/report?error=system_error");
        }
    }
    
    private void updatePayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String paymentIdStr = request.getParameter("paymentId");
            String amountPaidStr = request.getParameter("amountPaid");
            String paymentMethod = request.getParameter("paymentMethod");
            String paymentStatus = request.getParameter("paymentStatus");
            
            // Validation
            if (paymentIdStr == null || paymentIdStr.trim().isEmpty() ||
                amountPaidStr == null || amountPaidStr.trim().isEmpty() ||
                paymentMethod == null || paymentMethod.trim().isEmpty() ||
                paymentStatus == null || paymentStatus.trim().isEmpty()) {
                
                request.setAttribute("error", "All fields are required.");
                showEditPayment(request, response);
                return;
            }
            
            int paymentId = Integer.parseInt(paymentIdStr);
            BigDecimal amountPaid = new BigDecimal(amountPaidStr);
            
            // Validate amount paid
            if (amountPaid.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("error", "Amount paid must be greater than zero.");
                showEditPayment(request, response);
                return;
            }
            
            // Validate payment method
            if (!paymentMethod.equals("Cash") && !paymentMethod.equals("Card") && !paymentMethod.equals("Online")) {
                request.setAttribute("error", "Invalid payment method selected.");
                showEditPayment(request, response);
                return;
            }
            
            // Validate payment status
            if (!paymentStatus.equals("Successful") && !paymentStatus.equals("Failed") && !paymentStatus.equals("Pending")) {
                request.setAttribute("error", "Invalid payment status selected.");
                showEditPayment(request, response);
                return;
            }
            
            // Get existing payment
            Payment payment = paymentDAO.getPaymentById(paymentId);
            if (payment == null) {
                response.sendRedirect(request.getContextPath() + "/payment/report?error=payment_not_found");
                return;
            }
            
            // Update payment
            payment.setAmountPaid(amountPaid);
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentStatus(paymentStatus);
            
            boolean success = paymentDAO.updatePayment(payment);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/payment/report?success=payment_updated");
            } else {
                request.setAttribute("error", "Failed to update payment. Please try again.");
                showEditPayment(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid payment ID or amount format.");
            showEditPayment(request, response);
        } catch (Exception e) {
            System.err.println("Error updating payment: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "System error occurred. Please try again.");
            showEditPayment(request, response);
        }
    }
    
    private void filterPayments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String filterType = request.getParameter("filterType");
            String filterValue = request.getParameter("filterValue");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            
            List<Payment> payments = null;
            String filterDescription = "";
            
            if ("status".equals(filterType) && filterValue != null && !filterValue.trim().isEmpty()) {
                payments = paymentDAO.getPaymentsByStatus(filterValue);
                filterDescription = "Status: " + filterValue;
            } else if ("method".equals(filterType) && filterValue != null && !filterValue.trim().isEmpty()) {
                payments = paymentDAO.getPaymentsByMethod(filterValue);
                filterDescription = "Method: " + filterValue;
            } else if ("date".equals(filterType) && startDate != null && endDate != null && 
                      !startDate.trim().isEmpty() && !endDate.trim().isEmpty()) {
                payments = paymentDAO.getPaymentsByDateRange(startDate, endDate);
                filterDescription = "Date Range: " + startDate + " to " + endDate;
            } else {
                payments = paymentDAO.getAllPayments();
                filterDescription = "All Payments";
            }
            
            request.setAttribute("payments", payments);
            request.setAttribute("filterDescription", filterDescription);
            request.setAttribute("pageTitle", "Payment Report");
            request.getRequestDispatcher("/WEB-INF/views/payment/report.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error filtering payments: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to filter payments. Please try again.");
            showPaymentReport(request, response);
        }
    }
}