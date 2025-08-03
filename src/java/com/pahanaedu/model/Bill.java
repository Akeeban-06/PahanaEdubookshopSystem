package model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private double totalAmount;
    private Date billDate;
    private Customer customer;
    private List<BillItem> billItems;
    
    // Default constructor
    public Bill() {}
    
    // Parameterized constructor
    public Bill(int customerId, double totalAmount) {
        this.customerId = customerId;
        this.totalAmount = totalAmount;
        this.billDate = new Date();
    }
    
    // Getters and Setters
    public int getBillId() {
        return billId;
    }
    
    public void setBillId(int billId) {
        this.billId = billId;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public Date getBillDate() {
        return billDate;
    }
    
    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }
    
    public Customer getCustomer() {
        return customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    
    public List<BillItem> getBillItems() {
        return billItems;
    }
    
    public void setBillItems(List<BillItem> billItems) {
        this.billItems = billItems;
    }
}

class BillItem {
    private int billItemId;
    private int billId;
    private int itemId;
    private int quantity;
    private double price;
    private Item item;
    
    // Default constructor
    public BillItem() {}
    
    // Parameterized constructor
    public BillItem(int billId, int itemId, int quantity, double price) {
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.price = price;
    }
    
    // Getters and Setters
    public int getBillItemId() {
        return billItemId;
    }
    
    public void setBillItemId(int billItemId) {
        this.billItemId = billItemId;
    }
    
    public int getBillId() {
        return billId;
    }
    
    public void setBillId(int billId) {
        this.billId = billId;
    }
    
    public int getItemId() {
        return itemId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public Item getItem() {
        return item;
    }
    
    public void setItem(Item item) {
        this.item = item;
    }
    
    public double getSubTotal() {
        return quantity * price;
    }
}