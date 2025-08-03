package com.pahanaedu.servlet;


import dao.ItemDAO;
import model.Item;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/item")
public class ItemServlet extends HttpServlet {
    
    private ItemDAO itemDAO = new ItemDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewItem(request, response);
                break;
            default:
                listItems(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addItem(request, response);
                break;
            case "update":
                updateItem(request, response);
                break;
            case "delete":
                deleteItem(request, response);
                break;
            default:
                listItems(request, response);
                break;
        }
    }
    
    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> items = itemDAO.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("item-list.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-item.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        Item item = itemDAO.getItemById(itemId);
        request.setAttribute("item", item);
        request.getRequestDispatcher("edit-item.jsp").forward(request, response);
    }
    
    private void viewItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        Item item = itemDAO.getItemById(itemId);
        request.setAttribute("item", item);
        request.getRequestDispatcher("view-item.jsp").forward(request, response);
    }
    
    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String itemName = request.getParameter("itemName");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        
        Item item = new Item(itemName, price, stock);
        
        if (itemDAO.addItem(item)) {
            request.setAttribute("success", "Item added successfully!");
        } else {
            request.setAttribute("error", "Failed to add item.");
        }
        
        listItems(request, response);
    }
    
    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String itemName = request.getParameter("itemName");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        
        Item item = new Item(itemName, price, stock);
        item.setItemId(itemId);
        
        if (itemDAO.updateItem(item)) {
            request.setAttribute("success", "Item updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update item.");
        }
        
        listItems(request, response);
    }
    
    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        
        if (itemDAO.deleteItem(itemId)) {
            request.setAttribute("success", "Item deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete item.");
        }
        
        listItems(request, response);
    }
}