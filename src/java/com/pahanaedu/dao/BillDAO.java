package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    
    public int createBill(Bill bill) {
        String sql = "INSERT INTO bills (customer_id, total_amount) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, bill.getCustomerId());
            stmt.setBigDecimal(2, bill.getTotalAmount());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public boolean addBillItem(BillItem billItem) {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billItem.getBillId());
            stmt.setInt(2, billItem.getItemId());
            stmt.setInt(3, billItem.getQuantity());
            stmt.setBigDecimal(4, billItem.getPrice());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Bill getBillById(int billId) {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                bill.setBillDate(rs.getTimestamp("bill_date"));
                
                // Get bill items - This is crucial for displaying items
                List<BillItem> billItems = getBillItems(billId);
                bill.setBillItems(billItems);
                
                // Debug logging (you can remove this after testing)
                System.out.println("BillDAO - Retrieved bill with " + billItems.size() + " items");
                
                return bill;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<BillItem> getBillItems(int billId) {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.*, i.item_name FROM bill_items bi " +
                    "JOIN items i ON bi.item_id = i.item_id WHERE bi.bill_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                BillItem billItem = new BillItem();
                billItem.setBillItemId(rs.getInt("bill_item_id"));
                billItem.setBillId(rs.getInt("bill_id"));
                billItem.setItemId(rs.getInt("item_id"));
                billItem.setQuantity(rs.getInt("quantity"));
                billItem.setPrice(rs.getBigDecimal("price"));
                billItem.setItemName(rs.getString("item_name"));
                billItems.add(billItem);
            }
            
            // Debug logging (you can remove this after testing)
            System.out.println("BillDAO - Found " + billItems.size() + " items for bill " + billId);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billItems;
    }
    
    /**
     * Get payment information for a specific bill
     */
    public String getPaymentMethod(int billId) {
        String sql = "SELECT payment_method FROM payments WHERE bill_id = ? ORDER BY payment_date DESC LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("payment_method");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get payment status for a specific bill
     */
    public String getPaymentStatus(int billId) {
        String sql = "SELECT payment_status FROM payments WHERE bill_id = ? ORDER BY payment_date DESC LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("payment_status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }
    
    /**
     * Create a payment record
     */
    public boolean createPayment(int billId, BigDecimal amount, String paymentMethod) {
        String sql = "INSERT INTO payments (bill_id, amount_paid, payment_method, payment_status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            stmt.setBigDecimal(2, amount);
            stmt.setString(3, paymentMethod);
            stmt.setString(4, "Successful"); // Default to successful
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Additional method to get all bills with payment info (useful for dashboard)
    public List<Bill> getAllBillsWithPayment() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT b.*, c.name as customer_name, p.payment_method, p.payment_status " +
                    "FROM bills b " +
                    "JOIN customers c ON b.customer_id = c.customer_id " +
                    "LEFT JOIN payments p ON b.bill_id = p.bill_id " +
                    "ORDER BY b.bill_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                bill.setBillDate(rs.getTimestamp("bill_date"));
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }
    
    // Legacy method to maintain compatibility
    public List<Bill> getAllBills() {
        return getAllBillsWithPayment();
    }
}