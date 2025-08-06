package com.pahanaedu.dao;

import com.pahanaedu.model.Payment;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    
    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO payments (bill_id, amount_paid, payment_method, payment_status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, payment.getBillId());
            stmt.setBigDecimal(2, payment.getAmountPaid());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.setString(4, payment.getPaymentStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding payment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updatePayment(Payment payment) {
        String sql = "UPDATE payments SET amount_paid = ?, payment_method = ?, payment_status = ? WHERE payment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setBigDecimal(1, payment.getAmountPaid());
            stmt.setString(2, payment.getPaymentMethod());
            stmt.setString(3, payment.getPaymentStatus());
            stmt.setInt(4, payment.getPaymentId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating payment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public Payment getPaymentById(int paymentId) {
        String sql = """
            SELECT p.*, b.total_amount as bill_total_amount, 
                   c.name as customer_name, c.account_number as customer_account_number
            FROM payments p 
            LEFT JOIN bills b ON p.bill_id = b.bill_id 
            LEFT JOIN customers c ON b.customer_id = c.customer_id 
            WHERE p.payment_id = ?
            """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPayment(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting payment by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = """
            SELECT p.*, b.total_amount as bill_total_amount, 
                   c.name as customer_name, c.account_number as customer_account_number
            FROM payments p 
            LEFT JOIN bills b ON p.bill_id = b.bill_id 
            LEFT JOIN customers c ON b.customer_id = c.customer_id 
            ORDER BY p.payment_date DESC
            """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all payments: " + e.getMessage());
            e.printStackTrace();
        }
        return payments;
    }
    
    public List<Payment> getPaymentsByStatus(String status) {
        List<Payment> payments = new ArrayList<>();
        String sql = """
            SELECT p.*, b.total_amount as bill_total_amount, 
                   c.name as customer_name, c.account_number as customer_account_number
            FROM payments p 
            LEFT JOIN bills b ON p.bill_id = b.bill_id 
            LEFT JOIN customers c ON b.customer_id = c.customer_id 
            WHERE p.payment_status = ?
            ORDER BY p.payment_date DESC
            """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting payments by status: " + e.getMessage());
            e.printStackTrace();
        }
        return payments;
    }
    
    public List<Payment> getPaymentsByMethod(String method) {
        List<Payment> payments = new ArrayList<>();
        String sql = """
            SELECT p.*, b.total_amount as bill_total_amount, 
                   c.name as customer_name, c.account_number as customer_account_number
            FROM payments p 
            LEFT JOIN bills b ON p.bill_id = b.bill_id 
            LEFT JOIN customers c ON b.customer_id = c.customer_id 
            WHERE p.payment_method = ?
            ORDER BY p.payment_date DESC
            """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, method);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting payments by method: " + e.getMessage());
            e.printStackTrace();
        }
        return payments;
    }
    
    public List<Payment> getPaymentsByDateRange(String startDate, String endDate) {
        List<Payment> payments = new ArrayList<>();
        String sql = """
            SELECT p.*, b.total_amount as bill_total_amount, 
                   c.name as customer_name, c.account_number as customer_account_number
            FROM payments p 
            LEFT JOIN bills b ON p.bill_id = b.bill_id 
            LEFT JOIN customers c ON b.customer_id = c.customer_id 
            WHERE DATE(p.payment_date) BETWEEN ? AND ?
            ORDER BY p.payment_date DESC
            """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting payments by date range: " + e.getMessage());
            e.printStackTrace();
        }
        return payments;
    }
    
    public boolean deletePayment(int paymentId) {
        String sql = "DELETE FROM payments WHERE payment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, paymentId);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Successfully deleted payment with ID: " + paymentId);
                return true;
            } else {
                System.out.println("No payment found with ID: " + paymentId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error deleting payment: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper method to map ResultSet to Payment object
    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("payment_id"));
        payment.setBillId(rs.getInt("bill_id"));
        payment.setAmountPaid(rs.getBigDecimal("amount_paid"));
        payment.setPaymentDate(rs.getTimestamp("payment_date"));
        payment.setPaymentMethod(rs.getString("payment_method"));
        payment.setPaymentStatus(rs.getString("payment_status"));
        
        // Set additional joined data
        payment.setBillTotalAmount(rs.getBigDecimal("bill_total_amount"));
        payment.setCustomerName(rs.getString("customer_name"));
        payment.setCustomerAccountNumber(rs.getString("customer_account_number"));
        
        return payment;
    }
    
    // Additional helper method to check if payment exists
    public boolean paymentExists(int paymentId) {
        String sql = "SELECT COUNT(*) FROM payments WHERE payment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking if payment exists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Method to get payment statistics
    public BigDecimal getTotalPaymentsByStatus(String status) {
        String sql = "SELECT COALESCE(SUM(amount_paid), 0) FROM payments WHERE payment_status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total payments by status: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
}