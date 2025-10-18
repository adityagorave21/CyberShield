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
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .page-header h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 5px;
        }
        
        .page-header p {
            color: #666;
            font-size: 14px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }
        
        .stat-icon {
            font-size: 48px;
        }
        
        .stat-info h3 {
            font-size: 36px;
            color: #333;
            margin-bottom: 5px;
        }
        
        .stat-info p {
            color: #666;
            font-size: 14px;
        }
        
        .stat-primary { border-left: 4px solid #667eea; }
        .stat-success { border-left: 4px solid #28a745; }
        .stat-info-card { border-left: 4px solid #17a2b8; }
        .stat-warning { border-left: 4px solid #ffc107; }
        .stat-danger { border-left: 4px solid #dc3545; }
        
        .info-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .info-section h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }
        
        .info-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
        
        .info-card p {
            margin: 10px 0;
            font-size: 14px;
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
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="page-header">
            <h1>Dashboard</h1>
            <p>Welcome back, <%= user.getEmpName() %>!</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card stat-primary">
                <div class="stat-icon">👥</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("totalEmployees") != null ? request.getAttribute("totalEmployees") : 0 %></h3>
                    <p>Total Employees</p>
                </div>
            </div>
            
            <div class="stat-card stat-success">
                <div class="stat-icon">👨‍💼</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("adminCount") != null ? request.getAttribute("adminCount") : 0 %></h3>
                    <p>Administrators</p>
                </div>
            </div>
            
            <div class="stat-card stat-info-card">
                <div class="stat-icon">💼</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("hrCount") != null ? request.getAttribute("hrCount") : 0 %></h3>
                    <p>HR Personnel</p>
                </div>
            </div>
            
            <div class="stat-card stat-warning">
                <div class="stat-icon">🧑‍💻</div>
                <div class="stat-info">
                    <h3><%= request.getAttribute("employeeCount") != null ? request.getAttribute("employeeCount") : 0 %></h3>
                    <p>Employees</p>
                </div>
            </div>
        </div>
        
        <% if ("Admin".equals(user.getRole())) { %>
        <div class="info-section" style="margin-bottom: 30px;">
            <h2>🚨 Security Threat Overview</h2>
            <div class="stats-grid">
                <div class="stat-card stat-danger">
                    <div class="stat-icon">⚠️</div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("highThreats") != null ? request.getAttribute("highThreats") : 0 %></h3>
                        <p>High Threats</p>
                    </div>
                </div>
                
                <div class="stat-card stat-warning">
                    <div class="stat-icon">⚡</div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("mediumThreats") != null ? request.getAttribute("mediumThreats") : 0 %></h3>
                        <p>Medium Threats</p>
                    </div>
                </div>
                
                <div class="stat-card stat-success">
                    <div class="stat-icon">✅</div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("lowThreats") != null ? request.getAttribute("lowThreats") : 0 %></h3>
                        <p>Low Threats</p>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        
        <div class="info-section">
            <h2>📊 System Information</h2>
            <div class="info-card">
                <p><strong>Your Role:</strong> <%= user.getRole() %></p>
                <p><strong>Department:</strong> <%= user.getDepartment() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
            </div>
        </div>
    </div>
</body>
</html>

