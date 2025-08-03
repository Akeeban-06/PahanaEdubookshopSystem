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
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        try {
            if (pathInfo.equals("/create")) {
                // Show bill creation form
                List<Customer> customers = customerDAO.getAllCustomers();
                List<Item> items = itemDAO.getAllItems();
                
                request.setAttribute("customers", customers);
                request.setAttribute("items", items);
                request.getRequestDispatcher("/WEB-INF/views/bill/create.jsp").forward(request, response);
                
            } else if (pathInfo.equals("/view")) {
                // View bill details
                int billId = Integer.parseInt(request.getParameter("billId"));
                Bill bill = billDAO.getBillById(billId);
                
                if (bill == null) {
                    response.sendRedirect(request.getContextPath() + "/dashboard?error=Bill+not+found");
                    return;
                }
                
                Customer customer = customerDAO.getCustomerById(bill.getCustomerId());
                
                if (customer == null) {
                    response.sendRedirect(request.getContextPath() + "/dashboard?error=Customer+not+found");
                    return;
                }
                
                request.setAttribute("bill", bill);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/bill/view.jsp").forward(request, response);
                
            } else if (pathInfo.equals("/print")) {
                // Print optimized version of bill
                int billId = Integer.parseInt(request.getParameter("billId"));
                Bill bill = billDAO.getBillById(billId);
                
                if (bill == null) {
                    response.sendRedirect(request.getContextPath() + "/dashboard?error=Bill+not+found");
                    return;
                }
                
                Customer customer = customerDAO.getCustomerById(bill.getCustomerId());
                request.setAttribute("bill", bill);
                request.setAttribute("customer", customer);
                request.setAttribute("printMode", true);
                request.getRequestDispatcher("/WEB-INF/views/bill/view.jsp").forward(request, response);
                
            } else if (pathInfo.equals("/customer")) {
                // View all bills for a customer
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                List<Bill> bills = billDAO.getBillsByCustomer(customerId);
                Customer customer = customerDAO.getCustomerById(customerId);
                
                request.setAttribute("bills", bills);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/bill/customerBills.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dashboard?error=Invalid+ID+format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard?error=Server+error");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/create")) {
            try {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                String[] itemIds = request.getParameterValues("itemId");
                String[] quantities = request.getParameterValues("quantity");
                
                if (itemIds == null || quantities == null || itemIds.length == 0) {
                    request.setAttribute("error", "Please select at least one item");
                    doGet(request, response);
                    return;
                }
                
                BigDecimal totalAmount = BigDecimal.ZERO;
                List<BillItem> billItems = new ArrayList<>();
                boolean validItems = false;
                
                for (int i = 0; i < itemIds.length; i++) {
                    if (!itemIds[i].isEmpty() && !quantities[i].isEmpty()) {
                        int itemId = Integer.parseInt(itemIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        
                        if (quantity <= 0) continue;
                        
                        Item item = itemDAO.getItemById(itemId);
                        if (item != null && item.getStock() >= quantity) {
                            BigDecimal subtotal = item.getPrice().multiply(BigDecimal.valueOf(quantity));
                            totalAmount = totalAmount.add(subtotal);
                            
                            BillItem billItem = new BillItem();
                            billItem.setItemId(itemId);
                            billItem.setQuantity(quantity);
                            billItem.setPrice(item.getPrice());
                            billItem.setItemName(item.getItemName());
                            billItems.add(billItem);
                            validItems = true;
                        }
                    }
                }
                
                if (!validItems) {
                    request.setAttribute("error", "No valid items selected");
                    doGet(request, response);
                    return;
                }
                
                // Create bill
                Bill bill = new Bill();
                bill.setCustomerId(customerId);
                bill.setTotalAmount(totalAmount);
                bill.setBillDate(new java.util.Date());
                
                int billId = billDAO.createBill(bill);
                
                if (billId <= 0) {
                    request.setAttribute("error", "Failed to create bill");
                    doGet(request, response);
                    return;
                }
                
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
                    "/bill/view?billId=" + billId + "&success=Bill+created+successfully");
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid input format");
                doGet(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "An error occurred while creating the bill");
                doGet(request, response);
            }
        }
    }
}