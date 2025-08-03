package com.pahanaedu.servlet;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/item/*")
public class ItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all items
            List<Item> items = itemDAO.getAllItems();
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/item/list.jsp").forward(request, response);

        } else if (pathInfo.equals("/add")) {
            // Show add item form
            request.getRequestDispatcher("/WEB-INF/views/item/add.jsp").forward(request, response);

        } else if (pathInfo.equals("/edit")) {
            // Show edit item form
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            Item item = itemDAO.getItemById(itemId);
            request.setAttribute("item", item);
            request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);

        } else if (pathInfo.equals("/delete")) {
            // Delete item
            int itemId = Integer.parseInt(request.getParameter("itemId"));

            if (itemDAO.deleteItem(itemId)) {
                request.setAttribute("success", "Item deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete item.");
            }

            // Reload item list
            List<Item> items = itemDAO.getAllItems();
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/item/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo.equals("/add")) {
            // Add new item
            String name = request.getParameter("itemName");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Item item = new Item(name, price, stock);

            if (itemDAO.addItem(item)) {
                request.setAttribute("success", "Item added successfully!");
            } else {
                request.setAttribute("error", "Failed to add item.");
            }
            request.getRequestDispatcher("/WEB-INF/views/item/add.jsp").forward(request, response);

        } else if (pathInfo.equals("/update")) {
            // Update existing item
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String name = request.getParameter("itemName");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Item item = new Item(name, price, stock);
            item.setItemId(itemId);

            if (itemDAO.updateItem(item)) {
                request.setAttribute("success", "Item updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update item.");
            }

            request.setAttribute("item", item);
            request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
        }
    }
}
