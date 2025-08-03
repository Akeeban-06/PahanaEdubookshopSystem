package com.pahanaedu.model;

import java.math.BigDecimal;

public class Item {
    private int itemId;
    private String itemName;
    private BigDecimal price;
    private int stock;
    
    // Constructors
    public Item() {}
    
    public Item(String itemName, BigDecimal price, int stock) {
        this.itemName = itemName;
        this.price = price;
        this.stock = stock;
    }
    
    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}