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
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/customer/edit.jsp").forward(request, response);

        } else if (pathInfo.equals("/view")) {
            // View customer details
            String accountNumber = request.getParameter("accountNumber");
            Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/customer/view.jsp").forward(request, response);

        } else if (pathInfo.equals("/delete")) {
            // Delete customer
            String accountNumber = request.getParameter("accountNumber");

            if (customerDAO.deleteCustomer(accountNumber)) {
                request.setAttribute("success", "Customer deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete customer.");
            }

            // Refresh list after delete
            List<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/WEB-INF/views/customer/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo.equals("/add")) {
            // Add new customer - UPDATED: Account number is now auto-generated
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

            // Use new constructor without account number (it will be auto-generated)
            Customer customer = new Customer(name, address, phone, unitsConsumed);

            if (customerDAO.addCustomer(customer)) {
                request.setAttribute("success", "Customer added successfully! Account Number: " + customer.getAccountNumber());
                request.setAttribute("generatedAccountNumber", customer.getAccountNumber());
            } else {
                request.setAttribute("error", "Failed to add customer. Please try again.");
            }
            request.getRequestDispatcher("/WEB-INF/views/customer/add.jsp").forward(request, response);

        } else if (pathInfo.equals("/update")) {
            // Update customer - account number remains unchanged
            String accountNumber = request.getParameter("accountNumber");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

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