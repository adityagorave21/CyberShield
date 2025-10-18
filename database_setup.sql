-- CyberShield Database Setup
-- Run this in MySQL Workbench or MySQL Command Line

DROP DATABASE IF EXISTS cybershield_db;
CREATE DATABASE cybershield_db;
USE cybershield_db;

-- Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'HR', 'Employee') DEFAULT 'Employee',
    department VARCHAR(50),
    phone VARCHAR(15),
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Login Activity Table
CREATE TABLE login_activity (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
    status ENUM('Success', 'Failed') NOT NULL,
    threat_level ENUM('Low', 'Medium', 'High') DEFAULT 'Low',
    remarks VARCHAR(255),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE
);

-- Insert Admin User (password: admin123 - hashed with SHA2)
INSERT INTO employees (emp_name, email, password, role, department, phone) 
VALUES ('System Admin', 'admin@cybershield.com', 
        SHA2('admin123', 256), 'Admin', 'IT Security', '9876543210');

-- Insert Sample HR User (password: hr123)
INSERT INTO employees (emp_name, email, password, role, department, phone) 
VALUES ('Sarah Johnson', 'hr@cybershield.com', 
        SHA2('hr123', 256), 'HR', 'Human Resources', '9876543211');

-- Insert Sample Employees (password: emp123)
INSERT INTO employees (emp_name, email, password, role, department, phone) 
VALUES 
('John Doe', 'john@cybershield.com', SHA2('emp123', 256), 'Employee', 'Engineering', '9876543212'),
('Emma Wilson', 'emma@cybershield.com', SHA2('emp123', 256), 'Employee', 'Marketing', '9876543213'),
('Michael Brown', 'michael@cybershield.com', SHA2('emp123', 256), 'Employee', 'Sales', '9876543214');

-- Insert some sample login activities
INSERT INTO login_activity (emp_id, ip_address, user_agent, status, threat_level, remarks)
VALUES 
(1, '192.168.1.100', 'Mozilla/5.0', 'Success', 'Low', 'Normal login'),
(2, '192.168.1.101', 'Mozilla/5.0', 'Success', 'Low', 'Normal login'),
(3, '192.168.1.102', 'Mozilla/5.0', 'Failed', 'Medium', 'Wrong password'),
(3, '192.168.1.102', 'Mozilla/5.0', 'Failed', 'High', 'Multiple failed attempts'),
(4, '192.168.1.103', 'Mozilla/5.0', 'Success', 'Low', 'Normal login');

SELECT 'Database setup completed successfully!' AS Status;
