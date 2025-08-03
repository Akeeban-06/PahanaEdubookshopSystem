package com.pahanaedu.model;

public class Customer {
    private int customerId;
    private String accountNumber;
    private String name;
    private String address;
    private String phone;
    private int unitsConsumed;
    
    // Constructors
    public Customer() {}
    
    public Customer(String accountNumber, String name, String address, String phone, int unitsConsumed) {
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.unitsConsumed = unitsConsumed;
    }
    
    // Getters and Setters
    public int getCustomerId() { 
        return customerId; 
    }
    
    public void setCustomerId(int customerId) { 
        this.customerId = customerId; 
    }
    
    public String getAccountNumber() { 
        return accountNumber; 
    }
    
    public void setAccountNumber(String accountNumber) { 
        this.accountNumber = accountNumber; 
    }
    
    public String getName() { 
        return name; 
    }
    
    public void setName(String name) { 
        this.name = name; 
    }
    
    public String getAddress() { 
        return address; 
    }
    
    public void setAddress(String address) { 
        this.address = address; 
    }
    
    public String getPhone() { 
        return phone; 
    }
    
    public void setPhone(String phone) { 
        this.phone = phone; 
    }
    
    public int getUnitsConsumed() { 
        return unitsConsumed; 
    }
    
    public void setUnitsConsumed(int unitsConsumed) { 
        this.unitsConsumed = unitsConsumed; 
    }
    
    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + customerId +
                ", accountNumber='" + accountNumber + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", unitsConsumed=" + unitsConsumed +
                '}';
    }
}