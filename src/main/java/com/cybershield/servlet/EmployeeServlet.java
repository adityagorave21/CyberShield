package com.cybershield.servlet;

import com.cybershield.dao.EmployeeDAO;
import com.cybershield.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() {
        employeeDAO = new EmployeeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteEmployee(request, response);
                break;
            default:
                listEmployees(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addEmployee(request, response);
        } else if ("update".equals(action)) {
            updateEmployee(request, response);
        }
    }
    
    private void listEmployees(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Employee> employees = employeeDAO.getAllEmployees();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("employees.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("add-employee.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int empId = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeDAO.getEmployeeById(empId);
        request.setAttribute("employee", employee);
        request.getRequestDispatcher("edit-employee.jsp").forward(request, response);
    }
    
    private void addEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String department = request.getParameter("department");
        String phone = request.getParameter("phone");
        
        Employee employee = new Employee();
        employee.setEmpName(name);
        employee.setEmail(email);
        employee.setPassword(password);
        employee.setRole(role);
        employee.setDepartment(department);
        employee.setPhone(phone);
        
        boolean success = employeeDAO.addEmployee(employee);
        
        if (success) {
            request.setAttribute("message", "Employee added successfully!");
        } else {
            request.setAttribute("error", "Failed to add employee. Email might already exist.");
        }
        
        listEmployees(request, response);
    }
    
    private void updateEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int empId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String department = request.getParameter("department");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");
        
        Employee employee = new Employee();
        employee.setEmpId(empId);
        employee.setEmpName(name);
        employee.setEmail(email);
        employee.setRole(role);
        employee.setDepartment(department);
        employee.setPhone(phone);
        employee.setStatus(status);
        
        boolean success = employeeDAO.updateEmployee(employee);
        
        if (success) {
            request.setAttribute("message", "Employee updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update employee.");
        }
        
        listEmployees(request, response);
    }
    
    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int empId = Integer.parseInt(request.getParameter("id"));
        boolean success = employeeDAO.deleteEmployee(empId);
        
        if (success) {
            request.setAttribute("message", "Employee deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete employee.");
        }
        
        listEmployees(request, response);
    }
}
