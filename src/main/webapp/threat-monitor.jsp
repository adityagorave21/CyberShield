<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cybershield.model.Employee" %>
<%@ page import="com.cybershield.model.LoginActivity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Employee user = (Employee) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    
    if (!"Admin".equals(user.getRole())) {
        response.sendRedirect("dashboard");
        return;
    }
    
    List<LoginActivity> activities = (List<LoginActivity>) request.getAttribute("activities");
    String currentFilter = (String) request.getAttribute("filter");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Threat Monitor - CyberShield</title>
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
            <a href="employees">Employees</a>
            <a href="threats" class="active">Threat Monitor</a>
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
            <h1>?? Threat Monitor</h1>
            <p>Real-time login activity and security threats</p>
        </div>
        
        <div class="filter-section">
            <label>Filter by Threat Level:</label>
            <div class="filter-buttons">
                <a href="threats" class="btn btn-sm <%= currentFilter == null ? "btn-primary" : "btn-secondary" %>">All</a>
                <a href="threats?filter=High" class="btn btn-sm <%= "High".equals(currentFilter) ? "btn-danger" : "btn-secondary" %>">High</a>
                <a href="threats?filter=Medium" class="btn btn-sm <%= "Medium".equals(currentFilter) ? "btn-warning" : "btn-secondary" %>">Medium</a>
                <a href="threats?filter=Low" class="btn btn-sm <%= "Low".equals(currentFilter) ? "btn-success" : "btn-secondary" %>">Low</a>
            </div>
        </div>
        
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Log ID</th>
                        <th>Employee</th>
                        <th>Login Time</th>
                        <th>IP Address</th>
                        <th>Status</th>
                        <th>Threat Level</th>
                        <th>Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (activities != null && !activities.isEmpty()) {
                        for (LoginActivity activity : activities) { 
                            String threatClass = "";
                            String statusClass = "";
                            
                            if ("High".equals(activity.getThreatLevel())) {
                                threatClass = "threat-high";
                            } else if ("Medium".equals(activity.getThreatLevel())) {
                                threatClass = "threat-medium";
                            } else {
                                threatClass = "threat-low";
                            }
                            
                            if ("Success".equals(activity.getStatus())) {
                                statusClass = "status-success";
                            } else {
                                statusClass = "status-failed";
                            }
                    %>
                            <tr class="<%= threatClass %>">
                                <td><%= activity.getLogId() %></td>
                                <td><strong><%= activity.getEmpName() != null ? activity.getEmpName() : "Unknown" %></strong></td>
                                <td><%= sdf.format(activity.getLoginTime()) %></td>
                                <td><%= activity.getIpAddress() %></td>
                                <td><span class="badge <%= statusClass %>"><%= activity.getStatus() %></span></td>
                                <td><span class="badge badge-<%= activity.getThreatLevel().toLowerCase() %>"><%= activity.getThreatLevel() %></span></td>
                                <td><%= activity.getRemarks() != null ? activity.getRemarks() : "N/A" %></td>
                            </tr>
                        <% }
                    } else { %>
                        <tr>
                            <td colspan="7" class="text-center">No login activities found</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
