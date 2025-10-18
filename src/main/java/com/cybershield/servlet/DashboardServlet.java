package com.cybershield.servlet;

import com.cybershield.dao.EmployeeDAO;
import com.cybershield.dao.LoginActivityDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet responsible for fetching dashboard statistics (employee counts and threat counts) 
 * and forwarding the data to the dashboard.jsp view.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;
    private LoginActivityDAO loginActivityDAO;
    
    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
        loginActivityDAO = new LoginActivityDAO();
        System.out.println("DashboardServlet initialized!");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("========================================");
        System.out.println("DEBUG: Dashboard Access Attempt");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("❌ No session found - redirecting to login");
            System.out.println("========================================");
            response.sendRedirect("login");
            return;
        }
        
        System.out.println("✅ Session found - loading dashboard data");
        
        try {
            // Get dashboard statistics
            int totalEmployees = employeeDAO.getTotalEmployeeCount();
            int adminCount = employeeDAO.getEmployeeCountByRole("Admin");
            int hrCount = employeeDAO.getEmployeeCountByRole("HR");
            int employeeCount = employeeDAO.getEmployeeCountByRole("Employee");
            
            int highThreats = loginActivityDAO.getThreatCountByLevel("High");
            int mediumThreats = loginActivityDAO.getThreatCountByLevel("Medium");
            int lowThreats = loginActivityDAO.getThreatCountByLevel("Low");
            
            System.out.println("Total Employees: " + totalEmployees);
            System.out.println("Admins: " + adminCount);
            System.out.println("HR: " + hrCount);
            System.out.println("Employees: " + employeeCount);
            System.out.println("High Threats: " + highThreats);
            System.out.println("Medium Threats: " + mediumThreats);
            System.out.println("Low Threats: " + lowThreats);
            
            request.setAttribute("totalEmployees", totalEmployees);
            request.setAttribute("adminCount", adminCount);
            request.setAttribute("hrCount", hrCount);
            request.setAttribute("employeeCount", employeeCount);
            request.setAttribute("highThreats", highThreats);
            request.setAttribute("mediumThreats", mediumThreats);
            request.setAttribute("lowThreats", lowThreats);
            
            System.out.println("✅ Dashboard data loaded - forwarding to JSP");
            System.out.println("========================================");
            
            // --- CRITICAL CHANGE: Added / to make the path absolute ---
            // If the JSP is inside /WEB-INF/, you might need: request.getRequestDispatcher("/WEB-INF/dashboard.jsp").
            // For now, let's just make it absolute:
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("❌ ERROR loading dashboard data!");
            System.out.println("Error: " + e.getMessage());
            System.out.println("========================================");
            e.printStackTrace();
            throw new ServletException("Error loading dashboard", e);
        }
    }
}
