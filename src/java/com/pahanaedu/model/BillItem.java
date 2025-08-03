package com.pahanaedu.model;

import java.math.BigDecimal;

public class BillItem {
    private int billItemId;
    private int billId;
    private int itemId;
    private int quantity;
    private BigDecimal price;
    private String itemName; // For display purposes
    
    // Constructors
    public BillItem() {}
    
    public BillItem(int billId, int itemId, int quantity, BigDecimal price) {
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.price = price;
    }
    
    // Getters and Setters
    public int getBillItemId() { return billItemId; }
    public void setBillItemId(int billItemId) { this.billItemId = billItemId; }
    
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public BigDecimal getSubtotal() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }
}