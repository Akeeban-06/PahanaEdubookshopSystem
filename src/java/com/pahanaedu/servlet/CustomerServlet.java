package com.pahanaedu.servlet;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer/*")
public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all customers
            List<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/WEB-INF/views/customer/list.jsp").forward(request, response);

        } else if (pathInfo.equals("/add")) {
            // Show add customer form
            request.getRequestDispatcher("/WEB-INF/views/customer/add.jsp").forward(request, response);

        } else if (pathInfo.equals("/edit")) {
            // Show edit customer form
            String accountNumber = request.getParameter("accountNumber");
            Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/customer/edit.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Customer not found");
                List<Customer> customers = customerDAO.getAllCustomers();
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/WEB-INF/views/customer/list.jsp").forward(request, response);
            }

        } else if (pathInfo.equals("/view")) {
            // View customer details
            String accountNumber = request.getParameter("accountNumber");
            Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/customer/view.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Customer not found");
                List<Customer> customers = customerDAO.getAllCustomers();
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/WEB-INF/views/customer/list.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo.equals("/add")) {
            // Add new customer
            String accountNumber = request.getParameter("accountNumber");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            int unitsConsumed = 0; // Default value
            
              try {
            String unitsConsumedStr = request.getParameter("unitsConsumed");
            if (unitsConsumedStr != null && !unitsConsumedStr.isEmpty()) {
                unitsConsumed = Integer.parseInt(unitsConsumedStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid units consumed value");
            request.getRequestDispatcher("/WEB-INF/views/customer/add.jsp").forward(request, response);
            return;
        }

             // Check if account number already exists
        if (customerDAO.getCustomerByAccountNumber(accountNumber) != null) {
            request.setAttribute("error", "Account number already exists");
            request.getRequestDispatcher("/WEB-INF/views/customer/add.jsp").forward(request, response);
            return;
        }

            Customer customer = new Customer(accountNumber, name, address, phone, unitsConsumed);

            if (customerDAO.addCustomer(customer)) {
                request.setAttribute("success", "Customer added successfully!");
                response.sendRedirect(request.getContextPath() + "/customer/");
                return;
            } else {
                request.setAttribute("error", "Failed to add customer. Please try again.");
            }
            request.getRequestDispatcher("/WEB-INF/views/customer/add.jsp").forward(request, response);

        } else if (pathInfo.equals("/update")) {
            // Update customer
            String accountNumber = request.getParameter("accountNumber");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            int unitsConsumed = 0;
            
            try {
                unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid units consumed value");
                Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/customer/edit.jsp").forward(request, response);
                return;
            }

            Customer customer = new Customer(accountNumber, name, address, phone, unitsConsumed);

            if (customerDAO.updateCustomer(customer)) {
                request.setAttribute("success", "Customer updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update customer.");
            }

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/customer/edit.jsp").forward(request, response);
        }
    }
}