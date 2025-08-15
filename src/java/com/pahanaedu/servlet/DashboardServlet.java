package com.pahanaedu.servlet;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    
    private BillDAO billDAO = new BillDAO();
    private CustomerDAO customerDAO = new CustomerDAO();
    private ItemDAO itemDAO = new ItemDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        // ✅ Handle one-time login success message
        String loginSuccess = (String) session.getAttribute("loginSuccess");
        if (loginSuccess != null) {
            request.setAttribute("loginSuccess", loginSuccess);
            session.removeAttribute("loginSuccess"); // Show once only
        }
        
        try {
            // Fetch dashboard statistics
            BigDecimal totalSales = billDAO.getTotalSales();
            int totalBills = billDAO.getTotalBillCount();
            int totalCustomers = customerDAO.getAllCustomers().size();
            int totalItems = itemDAO.getAllItems().size();
            
            // Fetch recent bills for overview (limit to 6 for dashboard)
            List<Bill> recentBills = billDAO.getAllBillsWithPayment();
            if (recentBills.size() > 6) {
                recentBills = recentBills.subList(0, 6); // Show only first 6 bills on dashboard
            }
            
            // Create customer map for bill display
            Map<Integer, Customer> customerMap = new HashMap<>();
            Map<Integer, String> paymentMethods = new HashMap<>();
            Map<Integer, String> paymentStatuses = new HashMap<>();
            
            // Get customer and payment info for recent bills
            for (Bill bill : recentBills) {
                if (!customerMap.containsKey(bill.getCustomerId())) {
                    Customer customer = customerDAO.getCustomerById(bill.getCustomerId());
                    if (customer != null) {
                        customerMap.put(bill.getCustomerId(), customer);
                    }
                }
                
                // Get payment information
                String paymentMethod = billDAO.getPaymentMethod(bill.getBillId());
                String paymentStatus = billDAO.getPaymentStatus(bill.getBillId());
                
                paymentMethods.put(bill.getBillId(), paymentMethod);
                paymentStatuses.put(bill.getBillId(), paymentStatus);
            }
            
            // Set all attributes for the JSP
            request.setAttribute("totalSales", totalSales);
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("recentBills", recentBills);
            request.setAttribute("customerMap", customerMap);
            request.setAttribute("paymentMethods", paymentMethods);
            request.setAttribute("paymentStatuses", paymentStatuses);
            
            System.out.println("DashboardServlet: Dashboard loaded with " + recentBills.size() + " recent bills");
            System.out.println("DashboardServlet: Statistics - Sales: " + totalSales + ", Bills: " + totalBills + 
                             ", Customers: " + totalCustomers + ", Items: " + totalItems);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
}