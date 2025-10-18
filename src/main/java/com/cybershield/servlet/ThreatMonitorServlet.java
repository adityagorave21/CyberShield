package com.cybershield.servlet;

import com.cybershield.dao.LoginActivityDAO;
import com.cybershield.model.LoginActivity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/threats")
public class ThreatMonitorServlet extends HttpServlet {
    private LoginActivityDAO loginActivityDAO;
    
    @Override
    public void init() {
        loginActivityDAO = new LoginActivityDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String filter = request.getParameter("filter");
        List<LoginActivity> activities;
        
        if (filter != null && !filter.isEmpty()) {
            activities = loginActivityDAO.getActivitiesByThreatLevel(filter);
            request.setAttribute("filter", filter);
        } else {
            activities = loginActivityDAO.getAllActivities();
        }
        
        request.setAttribute("activities", activities);
        request.getRequestDispatcher("threat-monitor.jsp").forward(request, response);
    }
}
