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
        System.out.println("ItemServlet doGet - pathInfo: " + pathInfo); // Debug log

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
            String itemIdParam = request.getParameter("itemId");
            System.out.println("Edit - itemId parameter: " + itemIdParam); // Debug log
            
            try {
                int itemId = Integer.parseInt(itemIdParam);
                Item item = itemDAO.getItemById(itemId);
                if (item != null) {
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Item not found.");
                    List<Item> items = itemDAO.getAllItems();
                    request.setAttribute("items", items);
                    request.getRequestDispatcher("/WEB-INF/views/item/list.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid itemId parameter: " + itemIdParam); // Debug log
                request.setAttribute("error", "Invalid item ID: " + itemIdParam);
                List<Item> items = itemDAO.getAllItems();
                request.setAttribute("items", items);
                request.getRequestDispatcher("/WEB-INF/views/item/list.jsp").forward(request, response);
            }

        } else if (pathInfo.equals("/delete")) {
            // Delete item
            String itemIdParam = request.getParameter("itemId");
            System.out.println("Delete - itemId parameter: " + itemIdParam); // Debug log
            System.out.println("Delete - Query string: " + request.getQueryString()); // Debug log
            
            if (itemIdParam == null || itemIdParam.trim().isEmpty()) {
                System.err.println("itemId parameter is null or empty"); // Debug log
                request.setAttribute("error", "Item ID is required for deletion.");
            } else {
                try {
                    int itemId = Integer.parseInt(itemIdParam.trim());
                    System.out.println("Attempting to delete item with ID: " + itemId); // Debug log

                    if (itemDAO.deleteItem(itemId)) {
                        request.setAttribute("success", "Item deleted successfully!");
                        System.out.println("Item " + itemId + " deleted successfully"); // Debug log
                    } else {
                        request.setAttribute("error", "Failed to delete item. Item may be referenced in existing bills or does not exist.");
                        System.err.println("Failed to delete item " + itemId); // Debug log
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Invalid itemId parameter: " + itemIdParam); // Debug log
                    request.setAttribute("error", "Invalid item ID: " + itemIdParam);
                } catch (Exception e) {
                    System.err.println("Error during deletion: " + e.getMessage()); // Debug log
                    e.printStackTrace();
                    request.setAttribute("error", "An error occurred while deleting the item: " + e.getMessage());
                }
            }

            // Reload item list
            List<Item> items = itemDAO.getAllItems();
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/item/list.jsp").forward(request, response);
        } else {
            // Unknown path
            System.err.println("Unknown path: " + pathInfo); // Debug log
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println("ItemServlet doPost - pathInfo: " + pathInfo); // Debug log

        if (pathInfo.equals("/add")) {
            // Add new item
            try {
                String name = request.getParameter("itemName");
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                // Basic validation
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("error", "Item name is required.");
                    request.getRequestDispatcher("/WEB-INF/views/item/add.jsp").forward(request, response);
                    return;
                }

                if (price.compareTo(BigDecimal.ZERO) < 0) {
                    request.setAttribute("error", "Price cannot be negative.");
                    request.getRequestDispatcher("/WEB-INF/views/item/add.jsp").forward(request, response);
                    return;
                }

                if (stock < 0) {
                    request.setAttribute("error", "Stock cannot be negative.");
                    request.getRequestDispatcher("/WEB-INF/views/item/add.jsp").forward(request, response);
                    return;
                }

                Item item = new Item(name.trim(), price, stock);

                if (itemDAO.addItem(item)) {
                    request.setAttribute("success", "Item added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add item.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price or stock value.");
            } catch (Exception e) {
                request.setAttribute("error", "An error occurred while adding the item.");
                e.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/views/item/add.jsp").forward(request, response);

        } else if (pathInfo.equals("/update")) {
            // Update existing item
            try {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                String name = request.getParameter("itemName");
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                // Basic validation
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("error", "Item name is required.");
                    Item item = itemDAO.getItemById(itemId);
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
                    return;
                }

                if (price.compareTo(BigDecimal.ZERO) < 0) {
                    request.setAttribute("error", "Price cannot be negative.");
                    Item item = itemDAO.getItemById(itemId);
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
                    return;
                }

                if (stock < 0) {
                    request.setAttribute("error", "Stock cannot be negative.");
                    Item item = itemDAO.getItemById(itemId);
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
                    return;
                }

                Item item = new Item(name.trim(), price, stock);
                item.setItemId(itemId);

                if (itemDAO.updateItem(item)) {
                    request.setAttribute("success", "Item updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update item.");
                }

                request.setAttribute("item", item);
                request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid item ID, price, or stock value.");
                try {
                    int itemId = Integer.parseInt(request.getParameter("itemId"));
                    Item item = itemDAO.getItemById(itemId);
                    request.setAttribute("item", item);
                } catch (Exception ex) {
                    // Handle case where itemId is also invalid
                }
                request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "An error occurred while updating the item.");
                e.printStackTrace();
                try {
                    int itemId = Integer.parseInt(request.getParameter("itemId"));
                    Item item = itemDAO.getItemById(itemId);
                    request.setAttribute("item", item);
                } catch (Exception ex) {
                    // Handle case where itemId is also invalid
                }
                request.getRequestDispatcher("/WEB-INF/views/item/edit.jsp").forward(request, response);
            }
        } else {
            // Unknown path
            System.err.println("Unknown POST path: " + pathInfo); // Debug log
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}