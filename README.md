# CyberShield: Employee Access & Threat Monitoring System

**Project Type:** Java | JSP | Servlet | JDBC | MySQL

## Overview
CyberShield is a secure web-based application designed to manage employee access permissions and monitor login activities in an organization. It provides role-based authentication, a dashboard for admins, and logs suspicious login attempts. This project demonstrates core Java development, JDBC database connectivity, and web security concepts.

## Features
- Role-based authentication: Admin, HR, and Employee login
- Employee management: Add, update, delete employee details
- Login activity tracking: Logs all login attempts with timestamps and status (Success/Failed)
- Admin dashboard: View analytics, security logs, and overall employee activity
- Secure password handling: Passwords are hashed before storage in the database

## Tech Stack
- Backend: Java, JSP, Servlet, JDBC
- Database: MySQL
- Frontend: JSP, HTML, CSS
- Libraries: MySQL Connector/J

## Folder Structure
CyberShield/
├── src/           <- Java source files (Servlets, DB connection, Models)
├── WebContent/    <- JSP pages, HTML, CSS
├── lib/           <- MySQL JDBC connector
└── build/         <- Compiled classes

## How to Run
1. Clone the repository: `git clone <repository-url>`
2. Import the project into Eclipse or IntelliJ.
3. Add the MySQL connector JAR from `lib/` to your build path.
4. Set up the MySQL database using the provided SQL scripts.
5. Run the project on a local server (Apache Tomcat).
6. Access the app in your browser: `http://localhost:8080/CyberShield`

## Database Setup
- Database name: `cybershield_db`
- Tables: `employees`, `login_activity`

## Why This Project
- Demonstrates enterprise-level software development using core Java and web technologies.
- Shows skills in database connectivity, authentication, and web app deployment.
- Great for Java developer and SDE interviews.
