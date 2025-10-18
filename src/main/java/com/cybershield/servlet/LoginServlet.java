package com.cybershield.servlet;

import com.cybershield.dao.EmployeeDAO;
import com.cybershield.dao.LoginActivityDAO;
import com.cybershield.model.Employee;
import com.cybershield.model.LoginActivity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;
    private LoginActivityDAO loginActivityDAO;
    
    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
        loginActivityDAO = new LoginActivityDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String ipAddress = request.getRemoteAddr();
        String userAgent = request.getHeader("User-Agent");
        
        Employee employee = employeeDAO.authenticate(email, password);
        
        if (employee != null) {
            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("user", employee);
            session.setAttribute("userId", employee.getEmpId());
            session.setAttribute("userName", employee.getEmpName());
            session.setAttribute("userRole", employee.getRole());
            
            // Log successful login
            LoginActivity activity = new LoginActivity();
            activity.setEmpId(employee.getEmpId());
            activity.setIpAddress(ipAddress);
            activity.setUserAgent(userAgent);
            activity.setStatus("Success");
            activity.setThreatLevel("Low");
            activity.setRemarks("Normal login");
            loginActivityDAO.logActivity(activity);
            
            response.sendRedirect("dashboard");
        } else {
            // Failed login - find employee by email to log attempt
            LoginActivity activity = new LoginActivity();
            activity.setEmpId(0); // Unknown employee
            activity.setIpAddress(ipAddress);
            activity.setUserAgent(userAgent);
            activity.setStatus("Failed");
            activity.setThreatLevel("Medium");
            activity.setRemarks("Invalid credentials");
            loginActivityDAO.logActivity(activity);
            
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
