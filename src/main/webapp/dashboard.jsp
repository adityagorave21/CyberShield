<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cybershield.model.Employee" %>
<%
    Employee user = (Employee) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - CyberShield</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="navbar">
        <div class="nav-brand">
            <span class="logo">???</span>
            <span>CyberShield</span>
        </div>
        <div class="nav-menu">
            <a href="dashboard" class="active">Dashboard</a>
            <% if ("Admin".equals(user.getRole()) || "HR".equals(user.getRole())) { %>
                <a href="employees">Employees</a>
            <% } %>
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
            <h1>Dashboard</h1>
            <p>Welcome back, <%= user.getEmpName() %>!</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card stat-primary">
                <div class="stat-icon">??</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("totalEmployees") %></h3>
                    <p>Total Employees</p>
                </div>
            </div>
            
            <div class="stat-card stat-success">
                <div class="stat-icon">?????</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("adminCount") %></h3>
                    <p>Administrators</p>
                </div>
            </div>
            
            <div class="stat-card stat-info">
                <div class="stat-icon">??</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("hrCount") %></h3>
                    <p>HR Personnel</p>
                </div>
            </div>
            
            <div class="stat-card stat-warning">
                <div class="stat-icon">?????</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("employeeCount") %></h3>
                    <p>Employees</p>
                </div>
            </div>
        </div>
        
        <% if ("Admin".equals(user.getRole())) { %>
        <div class="threat-section">
            <h2>?? Security Threat Overview</h2>
            <div class="stats-grid">
                <div class="stat-card stat-danger">
                    <div class="stat-icon">??</div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("highThreats") %></h3>
                        <p>High Threats</p>
                    </div>
                </div>
                
                <div class="stat-card stat-warning">
                    <div class="stat-icon">?</div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("mediumThreats") %></h3>
                        <p>Medium Threats</p>
                    </div>
                </div>
                
                <div class="stat-card stat-success">
                    <div class="stat-icon">?</div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("lowThreats") %></h3>
                        <p>Low Threats</p>
                    </div>
                </div>
            </div>
            
            <div class="quick-actions">
                <a href="threats" class="btn btn-primary">View All Threats ?</a>
            </div>
        </div>
        <% } %>
        
        <div class="info-section">
            <h2>?? System Information</h2>
            <div class="info-card">
                <p><strong>Your Role:</strong> <%= user.getRole() %></p>
                <p><strong>Department:</strong> <%= user.getDepartment() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
            </div>
        </div>
    </div>
</body>
</html>
