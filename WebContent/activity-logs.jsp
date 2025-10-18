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
    <style>
        /* --- Your existing CSS goes here (unchanged) --- */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .navbar { background: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); }
        .nav-brand { display: flex; align-items: center; font-size: 24px; font-weight: bold; color: #667eea; }
        .nav-brand .logo { margin-right: 10px; font-size: 30px; }
        .nav-menu { display: flex; gap: 20px; }
        .nav-menu a { text-decoration: none; color: #333; font-weight: 500; padding: 8px 16px; border-radius: 6px; transition: all 0.3s ease; }
        .nav-menu a:hover, .nav-menu a.active { background: #667eea; color: white; }
        .nav-user { display: flex; align-items: center; gap: 15px; }
        .user-info strong { display: block; font-size: 14px; color: #333; }
        .user-info small { font-size: 12px; color: #666; }
        .btn { padding: 8px 16px; border: none; border-radius: 6px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; display: inline-block; transition: all 0.3s ease; }
        .btn-primary { background: #667eea; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-warning { background: #ffc107; color: #333; }
        .btn-success { background: #28a745; color: white; }
        .btn-sm { padding: 6px 12px; font-size: 12px; }
        .container { max-width: 1400px; margin: 30px auto; padding: 0 20px; }
        .page-header { background: white; padding: 30px; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); }
        .page-header h1 { font-size: 32px; color: #333; margin-bottom: 5px; }
        .page-header p { color: #666; font-size: 14px; }
        .filter-section { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); }
        .filter-section label { display: block; margin-bottom: 10px; font-weight: 600; }
        .filter-buttons { display: flex; gap: 10px; flex-wrap: wrap; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); overflow-x: auto; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table thead { background: #667eea; color: white; }
        .data-table th, .data-table td { padding: 12px 15px; text-align: left; font-size: 14px; }
        .data-table tbody tr { border-bottom: 1px solid #e0e0e0; transition: background 0.3s ease; }
        .data-table tbody tr:hover { background: #f8f9fa; }
        .badge { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600; }
        .badge-high { background: #dc3545; color: white; }
        .badge-medium { background: #ffc107; color: #333; }
        .badge-low { background: #28a745; color: white; }
        .status-success { background: #28a745; color: white; }
        .status-failed { background: #dc3545; color: white; }
        .threat-high { background: #fff5f5; }
        .threat-medium { background: #fffbf0; }
        .threat-low { background: #f0fff4; }
        .text-center { text-align: center; }
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
            <h1>🚨 Threat Monitor</h1>
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
                            if ("High".equals(activity.getThreatLevel())) {
                                threatClass = "threat-high";
                            } else if ("Medium".equals(activity.getThreatLevel())) {
                                threatClass = "threat-medium";
                            } else {
                                threatClass = "threat-low";
                            }
                    %>
                    <tr class="<%= threatClass %>">
                        <td><%= activity.getLogId() %></td>
                        <td><%= activity.getEmpName() %></td>
                        <td><%= sdf.format(activity.getLoginTime()) %></td>
                        <td><%= activity.getIpAddress() %></td>
                        <td class="<%= "Success".equals(activity.getStatus()) ? "status-success" : "status-failed" %>">
                            <%= activity.getStatus() %>
                        </td>
                        <td>
                            <span class="badge badge-<%= activity.getThreatLevel().toLowerCase() %>">
                                <%= activity.getThreatLevel() %>
                            </span>
                        </td>
                        <td><%= activity.getRemarks() %></td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="7" class="text-center">No activities found</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
