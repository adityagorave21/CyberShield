<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cybershield.model.Employee" %>
<%@ page import="java.util.List" %>
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
    
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employees - CyberShield</title>
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
            <h1>Employee Management</h1>
            <a href="employees?action=add" class="btn btn-primary">+ Add Employee</a>
        </div>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Department</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (employees != null && !employees.isEmpty()) {
                        for (Employee emp : employees) { %>
                            <tr>
                                <td><%= emp.getEmpId() %></td>
                                <td><%= emp.getEmpName() %></td>
                                <td><%= emp.getEmail() %></td>
                                <td><span class="badge badge-<%= emp.getRole().toLowerCase() %>"><%= emp.getRole() %></span></td>
                                <td><%= emp.getDepartment() %></td>
                                <td><%= emp.getPhone() != null ? emp.getPhone() : "N/A" %></td>
                                <td><span class="badge badge-<%= emp.getStatus().toLowerCase() %>"><%= emp.getStatus() %></span></td>
                                <td class="actions">
                                    <a href="employees?action=edit&id=<%= emp.getEmpId() %>" class="btn btn-sm btn-info">Edit</a>
                                    <% if ("Admin".equals(user.getRole())) { %>
                                        <a href="employees?action=delete&id=<%= emp.getEmpId() %>" 
                                           class="btn btn-sm btn-danger" 
                                           onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
                                    <% } %>
                                </td>
                            </tr>
                        <% }
                    } else { %>
                        <tr>
                            <td colspan="8" class="text-center">No employees found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
