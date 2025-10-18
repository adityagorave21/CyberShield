<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cybershield.model.Employee" %>
<%
    Employee user = (Employee) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    
    if (!"Admin".equals(user.getRole()) && !"HR".equals(user.getRole())) {
        response.sendRedirect("dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee - CyberShield</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="nav-brand">
            <span class="logo">???</span>
            <span>CyberShield</span>
        </div>
        <div class="nav-menu">
            <a href="dashboard">Dashboard</a>
            <a href="employees" class="active">Employees</a>
            <% if ("Admin".equals(user.getRole())) { %>
                <a href="threats">Threat Monitor</a>
            <% } %>
        </div>
        <div class="nav-user">
            <span class="user-info">
                <strong><%= user.getEmpName() %></strong>
                <small><%= user.getRole() %></small>
            </span>
            <a href="logout" class="btn btn-sm btn-danger">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="page-header">
            <h1>Add New Employee</h1>
            <a href="employees" class="btn btn-secondary">? Back to Employees</a>
        </div>
        
        <div class="form-container">
            <form action="employees" method="post" class="employee-form">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name" required 
                           placeholder="Enter full name">
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="Enter email address">
                </div>
                
                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter password" minlength="6">
                </div>
                
                <div class="form-group">
                    <label for="role">Role *</label>
                    <select id="role" name="role" required>
                        <option value="">Select Role</option>
                        <% if ("Admin".equals(user.getRole())) { %>
                            <option value="Admin">Admin</option>
                        <% } %>
                        <option value="HR">HR</option>
                        <option value="Employee">Employee</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="department">Department *</label>
                    <input type="text" id="department" name="department" required 
                           placeholder="Enter department">
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" 
                           placeholder="Enter phone number" pattern="[0-9]{10}">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Add Employee</button>
                    <a href="employees" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
