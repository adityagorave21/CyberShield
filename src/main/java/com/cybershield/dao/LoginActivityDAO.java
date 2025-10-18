package com.cybershield.dao;

import com.cybershield.model.LoginActivity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoginActivityDAO {
    
    // Log login activity
    public boolean logActivity(LoginActivity activity) {
        String sql = "INSERT INTO login_activity (emp_id, ip_address, user_agent, status, threat_level, remarks) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, activity.getEmpId());
            stmt.setString(2, activity.getIpAddress());
            stmt.setString(3, activity.getUserAgent());
            stmt.setString(4, activity.getStatus());
            stmt.setString(5, activity.getThreatLevel());
            stmt.setString(6, activity.getRemarks());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get all login activities
    public List<LoginActivity> getAllActivities() {
        List<LoginActivity> activities = new ArrayList<>();
        String sql = "SELECT la.*, e.emp_name FROM login_activity la " +
                    "JOIN employees e ON la.emp_id = e.emp_id " +
                    "ORDER BY la.login_time DESC LIMIT 100";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                LoginActivity activity = new LoginActivity();
                activity.setLogId(rs.getInt("log_id"));
                activity.setEmpId(rs.getInt("emp_id"));
                activity.setEmpName(rs.getString("emp_name"));
                activity.setLoginTime(rs.getTimestamp("login_time"));
                activity.setIpAddress(rs.getString("ip_address"));
                activity.setUserAgent(rs.getString("user_agent"));
                activity.setStatus(rs.getString("status"));
                activity.setThreatLevel(rs.getString("threat_level"));
                activity.setRemarks(rs.getString("remarks"));
                activities.add(activity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }
    
    // Get activities by threat level
    public List<LoginActivity> getActivitiesByThreatLevel(String threatLevel) {
        List<LoginActivity> activities = new ArrayList<>();
        String sql = "SELECT la.*, e.emp_name FROM login_activity la " +
                    "JOIN employees e ON la.emp_id = e.emp_id " +
                    "WHERE la.threat_level = ? " +
                    "ORDER BY la.login_time DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, threatLevel);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                LoginActivity activity = new LoginActivity();
                activity.setLogId(rs.getInt("log_id"));
                activity.setEmpId(rs.getInt("emp_id"));
                activity.setEmpName(rs.getString("emp_name"));
                activity.setLoginTime(rs.getTimestamp("login_time"));
                activity.setIpAddress(rs.getString("ip_address"));
                activity.setUserAgent(rs.getString("user_agent"));
                activity.setStatus(rs.getString("status"));
                activity.setThreatLevel(rs.getString("threat_level"));
                activity.setRemarks(rs.getString("remarks"));
                activities.add(activity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }
    
    // Get failed login count for an employee
    public int getFailedLoginCount(int empId, int hours) {
        String sql = "SELECT COUNT(*) FROM login_activity " +
                    "WHERE emp_id = ? AND status = 'Failed' " +
                    "AND login_time >= NOW() - INTERVAL ? HOUR";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, empId);
            stmt.setInt(2, hours);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get threat count by level
    public int getThreatCountByLevel(String threatLevel) {
        String sql = "SELECT COUNT(*) FROM login_activity WHERE threat_level = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, threatLevel);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get recent activities for an employee
    public List<LoginActivity> getRecentActivitiesByEmployee(int empId, int limit) {
        List<LoginActivity> activities = new ArrayList<>();
        String sql = "SELECT la.*, e.emp_name FROM login_activity la " +
                    "JOIN employees e ON la.emp_id = e.emp_id " +
                    "WHERE la.emp_id = ? " +
                    "ORDER BY la.login_time DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, empId);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                LoginActivity activity = new LoginActivity();
                activity.setLogId(rs.getInt("log_id"));
                activity.setEmpId(rs.getInt("emp_id"));
                activity.setEmpName(rs.getString("emp_name"));
                activity.setLoginTime(rs.getTimestamp("login_time"));
                activity.setIpAddress(rs.getString("ip_address"));
                activity.setUserAgent(rs.getString("user_agent"));
                activity.setStatus(rs.getString("status"));
                activity.setThreatLevel(rs.getString("threat_level"));
                activity.setRemarks(rs.getString("remarks"));
                activities.add(activity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }
}
