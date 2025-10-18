package com.cybershield.dao;

import com.cybershield.model.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {
    
    // Authenticate user
    public Employee authenticate(String email, String password) {
        String sql = "SELECT * FROM employees WHERE email = ? AND password = SHA2(?, 256) AND status = 'Active'";
        
        System.out.println("========================================");
        System.out.println("DEBUG: Authentication Attempt");
        System.out.println("Email received: [" + email + "]");
        System.out.println("Password received: [" + password + "]");
        System.out.println("Password length: " + password.length());
        System.out.println("========================================");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            System.out.println("Executing SQL query...");
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("✅ SUCCESS: User found in database!");
                Employee emp = new Employee();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setEmpName(rs.getString("emp_name"));
                emp.setEmail(rs.getString("email"));
                emp.setRole(rs.getString("role"));
                emp.setDepartment(rs.getString("department"));
                emp.setPhone(rs.getString("phone"));
                emp.setStatus(rs.getString("status"));
                System.out.println("Employee loaded: " + emp.getEmpName() + " (" + emp.getRole() + ")");
                System.out.println("========================================");
                return emp;
            } else {
                System.out.println("❌ FAILED: No user found with those credentials!");
                System.out.println("Possible reasons:");
                System.out.println("1. Email doesn't match");
                System.out.println("2. Password doesn't match");
                System.out.println("3. User status is not 'Active'");
                System.out.println("========================================");
            }
        } catch (SQLException e) {
            System.out.println("❌ SQL ERROR occurred!");
            System.out.println("Error message: " + e.getMessage());
            System.out.println("========================================");
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all employees
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM employees ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setEmpName(rs.getString("emp_name"));
                emp.setEmail(rs.getString("email"));
                emp.setRole(rs.getString("role"));
                emp.setDepartment(rs.getString("department"));
                emp.setPhone(rs.getString("phone"));
                emp.setStatus(rs.getString("status"));
                emp.setCreatedAt(rs.getTimestamp("created_at"));
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }
    
    // Get employee by ID
    public Employee getEmployeeById(int empId) {
        String sql = "SELECT * FROM employees WHERE emp_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, empId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Employee emp = new Employee();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setEmpName(rs.getString("emp_name"));
                emp.setEmail(rs.getString("email"));
                emp.setRole(rs.getString("role"));
                emp.setDepartment(rs.getString("department"));
                emp.setPhone(rs.getString("phone"));
                emp.setStatus(rs.getString("status"));
                return emp;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Add new employee
    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees (emp_name, email, password, role, department, phone) VALUES (?, ?, SHA2(?, 256), ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, emp.getEmpName());
            stmt.setString(2, emp.getEmail());
            stmt.setString(3, emp.getPassword());
            stmt.setString(4, emp.getRole());
            stmt.setString(5, emp.getDepartment());
            stmt.setString(6, emp.getPhone());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update employee
    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET emp_name = ?, email = ?, role = ?, department = ?, phone = ?, status = ? WHERE emp_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, emp.getEmpName());
            stmt.setString(2, emp.getEmail());
            stmt.setString(3, emp.getRole());
            stmt.setString(4, emp.getDepartment());
            stmt.setString(5, emp.getPhone());
            stmt.setString(6, emp.getStatus());
            stmt.setInt(7, emp.getEmpId());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Delete employee
    public boolean deleteEmployee(int empId) {
        String sql = "DELETE FROM employees WHERE emp_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, empId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get employee count by role
    public int getEmployeeCountByRole(String role) {
        String sql = "SELECT COUNT(*) FROM employees WHERE role = ? AND status = 'Active'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get total employee count
    public int getTotalEmployeeCount() {
        String sql = "SELECT COUNT(*) FROM employees WHERE status = 'Active'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}