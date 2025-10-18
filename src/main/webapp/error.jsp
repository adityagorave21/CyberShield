<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - CyberShield</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="login-body">
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="logo">??</div>
                <h1>Oops! Something went wrong</h1>
                <p>An error occurred while processing your request</p>
            </div>
            
            <div class="alert alert-error">
                <% if (exception != null) { %>
                    <p><strong>Error:</strong> <%= exception.getMessage() %></p>
                <% } else { %>
                    <p>The page you are looking for might have been removed or is temporarily unavailable.</p>
                <% } %>
            </div>
            
            <div class="quick-actions">
                <a href="dashboard" class="btn btn-primary">Go to Dashboard</a>
                <a href="login" class="btn btn-secondary">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html>
