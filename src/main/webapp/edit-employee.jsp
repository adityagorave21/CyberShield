<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cybershield.model.Employee" %>
<%
    Employee user = (Employee) session.getAttribute("user");
    Employee employee = (Employee) request.getAttribute("employee");
    
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
    <title>Edit Employee - CyberShield</title>
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
            <h1>Edit Employee</h1>
            <a href="employees" class="btn btn-secondary">? Back to Employees</a>
        </div>
        
        <% if (employee != null) { %>
        <div class="form-container">
            <form action="employees" method="post" class="employee-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= employee.getEmpId() %>">
                
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name" required 
                           value="<%= employee.getEmpName() %>">
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email" required 
                           value="<%= employee.getEmail() %>">
                </div>
                
                <div class="form-group">
                    <label for="role">Role *</label>
                    <select id="role" name="role" required>
                        <% if ("Admin".equals(user.getRole())) { %>
                            <option value="Admin" <%= "Admin".equals(employee.getRole()) ? "selected" : "" %>>Admin</option>
                        <% } %>
                        <option value="HR" <%= "HR".equals(employee.getRole()) ? "selected" : "" %>>HR</option>
                        <option value="Employee" <%= "Employee".equals(employee.getRole()) ? "selected" : "" %>>Employee</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="department">Department *</label>
                    <input type="text" id="department" name="department" required 
                           value="<%= employee.getDepartment() %>">
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" 
                           value="<%= employee.getPhone() != null ? employee.getPhone() : "" %>" 
                           pattern="[0-9]{10}">
                </div>
                
                <div class="form-group">
                    <label for="status">Status *</label>
                    <select id="status" name="status" required>
                        <option value="Active" <%= "Active".equals(employee.getStatus()) ? "selected" : "" %>>Active</option>
                        <option value="Inactive" <%= "Inactive".equals(employee.getStatus()) ? "selected" : "" %>>Inactive</option>
                    </select>
                </div>
                
                <div class="form-actions">
                    <button type="submit
" class="btn btn-primary">Update Employee</button>
                    <a href="employees" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
        <% } else { %>
            <div class="alert alert-error">
                Employee not found!
            </div>
        <% } %>
    </div>
</body>
</html>
