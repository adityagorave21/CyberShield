package com.secureaccess.model;

import java.util.Date;

public class LoginActivity {
    private int id;
    private int userId;
    private Date loginTime;
    private boolean success;
    private String ipAddress;

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public Date getLoginTime() { return loginTime; }
    public boolean isSuccess() { return success; }
    public String getIpAddress() { return ipAddress; }

    public void setId(int id) { this.id = id; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setLoginTime(Date loginTime) { this.loginTime = loginTime; }
    public void setSuccess(boolean success) { this.success = success; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
}
