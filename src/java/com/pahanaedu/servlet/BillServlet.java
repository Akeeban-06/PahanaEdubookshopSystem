package com.pahanaedu.servlet;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bill/*")
public class BillServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAO();
    private CustomerDAO customerDAO = new CustomerDAO();
    private ItemDAO itemDAO = new ItemDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/create")) {
            // Show bill creation form
            List<Customer> customers = customerDAO.getAllCustomers();
            List<Item> items = itemDAO.getAllItems();
            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/bill/create.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // View bill details - FIXED VERSION
            int billId = Integer.parseInt(request.getParameter("billId"));
            Bill bill = billDAO.getBillById(billId);
            
            if (bill != null) {
                // FIXED: Use getCustomerById instead of getCustomerByAccountNumber
                Customer customer = customerDAO.getCustomerById(bill.getCustomerId());
                
                // Debug logging (you can remove these after testing)
                System.out.println("Bill ID: " + billId);
                System.out.println("Bill found: " + (bill != null));
                System.out.println("Bill items count: " + (bill.getBillItems() != null ? bill.getBillItems().size() : 0));
                System.out.println("Customer found: " + (customer != null));
                
                request.setAttribute("bill", bill);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/bill/view.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Bill not found");
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/create")) {
            // Create new bill
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String[] itemIds = request.getParameterValues("itemId");
            String[] quantities = request.getParameterValues("quantity");
            
            if (itemIds != null && quantities != null) {
                BigDecimal totalAmount = BigDecimal.ZERO;
                List<BillItem> billItems = new ArrayList<>();
                
                // Calculate total and create bill items
                for (int i = 0; i < itemIds.length; i++) {
                    if (!itemIds[i].isEmpty() && !quantities[i].isEmpty()) {
                        int itemId = Integer.parseInt(itemIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        
                        Item item = itemDAO.getItemById(itemId);
                        if (item != null && item.getStock() >= quantity) {
                            BigDecimal subtotal = item.getPrice().multiply(BigDecimal.valueOf(quantity));
                            totalAmount = totalAmount.add(subtotal);
                            
                            BillItem billItem = new BillItem();
                            billItem.setItemId(itemId);
                            billItem.setQuantity(quantity);
                            billItem.setPrice(item.getPrice());
                            billItems.add(billItem);
                        }
                    }
                }
                
                if (!billItems.isEmpty()) {
                    // Create bill
                    Bill bill = new Bill(customerId, totalAmount);
                    int billId = billDAO.createBill(bill);
                    
                    if (billId > 0) {
                        // Add bill items and update stock
                        for (BillItem billItem : billItems) {
                            billItem.setBillId(billId);
                            billDAO.addBillItem(billItem);
                            
                            // Update stock
                            Item item = itemDAO.getItemById(billItem.getItemId());
                            itemDAO.updateStock(billItem.getItemId(), 
                                item.getStock() - billItem.getQuantity());
                        }
                        
                        response.sendRedirect(request.getContextPath() + 
                            "/bill/view?billId=" + billId + "&success=Bill created successfully");
                    } else {
                        request.setAttribute("error", "Failed to create bill.");
                        doGet(request, response);
                    }
                } else {
                    request.setAttribute("error", "No valid items selected.");
                    doGet(request, response);
                }
            } else {
                request.setAttribute("error", "Please select items and quantities.");
                doGet(request, response);
            }
        }
    }
}