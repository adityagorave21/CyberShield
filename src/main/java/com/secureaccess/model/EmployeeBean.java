package com.secureaccess.model;

public class EmployeeBean {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String hireDate;
    private String jobId;
    private double salary;
    private double commissionPct;
    private int managerId;
    private int departmentId;

    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getHireDate() { return hireDate; }
    public String getJobId() { return jobId; }
    public double getSalary() { return salary; }
    public double getCommissionPct() { return commissionPct; }
    public int getManagerId() { return managerId; }
    public int getDepartmentId() { return departmentId; }
}
