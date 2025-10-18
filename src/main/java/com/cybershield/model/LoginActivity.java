package com.cybershield.model;

import java.sql.Timestamp;

public class LoginActivity {
    private int logId;
    private int empId;
    private String empName;
    private Timestamp loginTime;
    private String ipAddress;
    private String userAgent;
    private String status;
    private String threatLevel;
    private String remarks;
    
    public LoginActivity() {}
    
    public LoginActivity(int empId, String ipAddress, String status, String threatLevel) {
        this.empId = empId;
        this.ipAddress = ipAddress;
        this.status = status;
        this.threatLevel = threatLevel;
    }
    
    // Getters and Setters
    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }
    
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }
    
    public String getEmpName() { return empName; }
    public void setEmpName(String empName) { this.empName = empName; }
    
    public Timestamp getLoginTime() { return loginTime; }
    public void setLoginTime(Timestamp loginTime) { this.loginTime = loginTime; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getUserAgent() { return userAgent; }
    public void setUserAgent(String userAgent) { this.userAgent = userAgent; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getThreatLevel() { return threatLevel; }
    public void setThreatLevel(String threatLevel) { this.threatLevel = threatLevel; }
    
    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
}
