package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    // Create a new bill in the database
    public int createBill(Bill bill) {
        String sql = "INSERT INTO bills (customer_id, total_amount, bill_date) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, bill.getCustomerId());
            stmt.setBigDecimal(2, bill.getTotalAmount());
            stmt.setTimestamp(3, new Timestamp(bill.getBillDate().getTime()));
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Add items to a bill
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

    // Get bill by ID with all items
    public Bill getBillById(int billId) {
    String billSql = "SELECT * FROM bill WHERE bill_id = ?";
    String itemsSql = "SELECT bi.*, i.item_name FROM bill_items bi " +
                     "JOIN item i ON bi.item_id = i.item_id " +
                     "WHERE bi.bill_id = ?";
    
    try (Connection conn = DatabaseConnection.getConnection()) {
        // Get bill information
        Bill bill = new Bill();
        try (PreparedStatement billStmt = conn.prepareStatement(billSql)) {
            billStmt.setInt(1, billId);
            ResultSet rs = billStmt.executeQuery();
            
            if (rs.next()) {
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                bill.setBillDate(rs.getTimestamp("bill_date"));
            } else {
                return null;  // Bill not found
            }
        }
        
        // Get bill items
        List<BillItem> items = new ArrayList<>();
        try (PreparedStatement itemsStmt = conn.prepareStatement(itemsSql)) {
            itemsStmt.setInt(1, billId);
            ResultSet rs = itemsStmt.executeQuery();
            
            while (rs.next()) {
                BillItem item = new BillItem();
                item.setBillItemId(rs.getInt("bill_item_id"));
                item.setBillId(rs.getInt("bill_id"));
                item.setItemId(rs.getInt("item_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setItemName(rs.getString("item_name"));
                items.add(item);
            }
        }
        
        bill.setBillItems(items);
        return bill;
    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }
}

    // Get all bills for a customer
    public List<Bill> getBillsByCustomer(int customerId) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bill WHERE customer_id = ? ORDER BY bill_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
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
}