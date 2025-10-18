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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .nav-brand {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
        }
        
        .nav-brand .logo {
            margin-right: 10px;
            font-size: 30px;
        }
        
        .nav-menu {
            display: flex;
            gap: 20px;
        }
        
        .nav-menu a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        
        .nav-menu a:hover,
        .nav-menu a.active {
            background: #667eea;
            color: white;
        }
        
        .nav-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-info strong {
            display: block;
            font-size: 14px;
            color: #333;
        }
        
        .user-info small {
            font-size: 12px;
            color: #666;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-info {
            background: #17a2b8;
            color: white;
        }
        
        .btn-sm {
            padding: 4px 8px;
            font-size: 12px;
        }
        
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h1 {
            font-size: 32px;
            color: #333;
        }
        
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .data-table thead {
            background: #667eea;
            color: white;
        }
        
        .data-table th,
        .data-table td {
            padding: 12px 15px;
            text-align: left;
            font-size: 14px;
        }
        
        .data-table tbody tr {
            border-bottom: 1px solid #e0e0e0;
            transition: background 0.3s ease;
        }
        
        .data-table tbody tr:hover {
            background: #f8f9fa;
        }
        
        .data-table .actions {
            display: flex;
            gap: 8px;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-admin { background: #667eea; color: white; }
        .badge-hr { background: #17a2b8; color: white; }
        .badge-employee { background: #6c757d; color: white; }
        .badge-active { background: #28a745; color: white; }
        .badge-inactive { background: #dc3545; color: white; }
        
        .text-center {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="nav-brand">
            <span class="logo">🛡️</span>
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