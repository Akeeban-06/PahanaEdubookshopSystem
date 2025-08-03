package com.pahanaedu.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private BigDecimal totalAmount;
    private Date billDate;
    private List<BillItem> billItems;
    
    // Constructors
    public Bill() {}
    
    public Bill(int customerId, BigDecimal totalAmount) {
        this.customerId = customerId;
        this.totalAmount = totalAmount;
        this.billDate = new Date();
    }
    
    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }
    
    public List<BillItem> getBillItems() { return billItems; }
    public void setBillItems(List<BillItem> billItems) { this.billItems = billItems; }
}
