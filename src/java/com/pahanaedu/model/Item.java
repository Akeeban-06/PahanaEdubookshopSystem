package com.pahanaedu.model;


public class Item {
    private int itemId;
    private String itemName;
    private double price;
    private int stock;
    
    // Default constructor
    public Item() {}
    
    // Parameterized constructor
    public Item(String itemName, double price, int stock) {
        this.itemName = itemName;
        this.price = price;
        this.stock = stock;
    }
    
    // Getters and Setters
    public int getItemId() {
        return itemId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    
    public String getItemName() {
        return itemName;
    }
    
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public int getStock() {
        return stock;
    }
    
    public void setStock(int stock) {
        this.stock = stock;
    }
}