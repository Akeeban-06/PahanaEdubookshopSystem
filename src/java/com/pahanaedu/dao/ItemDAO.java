package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    
    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (item_name, price, stock) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, item.getItemName());
            stmt.setBigDecimal(2, item.getPrice());
            stmt.setInt(3, item.getStock());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding item: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET item_name = ?, price = ?, stock = ? WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, item.getItemName());
            stmt.setBigDecimal(2, item.getPrice());
            stmt.setInt(3, item.getStock());
            stmt.setInt(4, item.getItemId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating item: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public Item getItemById(int itemId) {
        String sql = "SELECT * FROM items WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setStock(rs.getInt("stock"));
                return item;
            }
        } catch (SQLException e) {
            System.err.println("Error getting item by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY item_name";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setStock(rs.getInt("stock"));
                items.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
    
    public boolean deleteItem(int itemId) {
        // First check if item is referenced in any bills
        String checkSql = "SELECT COUNT(*) FROM bill_items WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            
            checkStmt.setInt(1, itemId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                // Item is referenced in bills, cannot delete
                System.out.println("Cannot delete item with ID " + itemId + " - it's referenced in existing bills");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error checking item references: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        
        // If no references found, proceed with deletion
        String sql = "DELETE FROM items WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Successfully deleted item with ID: " + itemId);
                return true;
            } else {
                System.out.println("No item found with ID: " + itemId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error deleting item: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateStock(int itemId, int newStock) {
        String sql = "UPDATE items SET stock = ? WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, newStock);
            stmt.setInt(2, itemId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating stock: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Additional helper method to check if item exists
    public boolean itemExists(int itemId) {
        String sql = "SELECT COUNT(*) FROM items WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking if item exists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Additional helper method to get items with low stock
    public List<Item> getLowStockItems(int threshold) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE stock <= ? ORDER BY stock ASC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, threshold);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setStock(rs.getInt("stock"));
                items.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error getting low stock items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
}