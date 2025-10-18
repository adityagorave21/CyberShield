package com.cybershield.model;

import java.sql.Timestamp;

public class Employee {
    private int empId;
    private String empName;
    private String email;
    private String password;
    private String role;
    private String department;
    private String phone;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    public Employee() {}
    
    public Employee(int empId, String empName, String email, String role, String department) {
        this.empId = empId;
        this.empName = empName;
        this.email = email;
        this.role = role;
        this.department = department;
    }
    
    // Getters and Setters
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }
    
    public String getEmpName() { return empName; }
    public void setEmpName(String empName) { this.empName = empName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}
