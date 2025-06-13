# 🛠️ Complaint Management System (JakartaEE 2025 - IJSE GDSE)

## Overview
A fully functional, synchronous web-based Complaint Management System built using **JSP**, **Jakarta EE (Servlets)**, **MySQL**, and **Apache Tomcat**. This system is designed to streamline the submission, tracking, and management of internal complaints for municipal employees and administrators.

---

## 📌 Project Highlights

🔐 **Role-Based Login System**  
📝 **Employee Complaint Submission**  
📂 **View, Edit & Delete Personal Complaints**  
🛠️ **Admin Panel for Status Updates & Management**  
📄 **Strict Form-Based GET/POST – No AJAX Used**  
⚙️ **Follows MVC Architecture (Model-View-Controller)**

---

## 🧱 Tech Stack

| Layer         | Technology                     |
|---------------|--------------------------------|
| Frontend      | JSP, HTML, CSS, JavaScript     |
| Backend       | Jakarta EE (Servlets), JavaBeans, DAO |
| Database      | MySQL                          |
| Connection    | Apache Commons DBCP            |
| Server        | Apache Tomcat                  |
| Architecture  | MVC (Model-View-Controller)    |

---

## Setup
1. Import project into IntelliJ or Eclipse
2. Configure Tomcat server
3. Import `/db/schema.sql` into MySQL
4. Set DB config in `DBCPDataSource.java`

---

## Run
Start Tomcat → Access `http://localhost:8080/CMS_Web_exploded/`

---

## 👥 User Roles

### 👨‍💼 Employee
- Login
- Submit new complaints
- View & edit own complaints (if pending)

### 👩‍💼 Admin
- View all complaints
- Update complaint statuses and remarks
- Delete complaints

---

## 🧪 Sample Login

| Role     | Username | Password  |
|----------|----------|-----------|
| Admin    | admin1   | admin123  |
| Employee | emp1     | emp123    |

> *These users must be inserted into your DB manually or through the form.*

---

## 🧑‍💻 Author

**Name:** Kalana Warnakulasooriya  
**Batch:** IJSE GDSE - 72  
**Branch:** Galle  

> “Crafted for real-world municipal complaint tracking – simple, clean, effective.”

---

## 📜 License

This project is developed for educational purposes under the IJSE GDSE program.
