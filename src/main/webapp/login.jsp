<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberShield - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="login-body">
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="logo">???</div>
                <h1>CyberShield</h1>
                <p>Employee Access & Threat Monitoring System</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="login" method="post" class="login-form">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="Enter your email" autocomplete="email">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter your password" autocomplete="current-password">
                </div>
                
                <button type="submit" class="btn btn-primary btn-block">
                    Login
                </button>
            </form>
            
            <div class="login-footer">
                <div class="demo-credentials">
                    <h4>?? Demo Credentials:</h4>
                    <p><strong>Admin:</strong> admin@cybershield.com / admin123</p>
                    <p><strong>HR:</strong> hr@cybershield.com / hr123</p>
                    <p><strong>Employee:</strong> john@cybershield.com / emp123</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
