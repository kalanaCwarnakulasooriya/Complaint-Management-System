CREATE DATABASE IF NOT EXISTS CMS;
USE CMS;

CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(100),
                       address VARCHAR(255),
                       mobile VARCHAR(15),
                       email VARCHAR(100) UNIQUE,
                       username VARCHAR(50) UNIQUE,
                       password VARCHAR(255),
                       department VARCHAR(100),
                       job_role ENUM('admin', 'employee')
);

CREATE TABLE complaints (
                            complaint_id INT PRIMARY KEY AUTO_INCREMENT,
                            user_id INT NOT NULL,
                            title VARCHAR(150) NOT NULL,
                            description TEXT NOT NULL,
                            status ENUM('pending', 'in-progress', 'resolved') DEFAULT 'pending',
                            remarks TEXT,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO users (name, address, mobile, email, username, password, department, job_role)
VALUES
-- Admin
('Kalana Warnakulasooriya', 'No. 12, Galle Road, Colombo 03', '0779524213', 'kalana.warnakulasooriya@gmail.com', 'kalana123', 'admin123', 'IT Department', 'admin'),

-- Employees
('Kamal Silva', '45, Kandy Road, Peradeniya', '0714567890', 'kamal.employee@gov.lk', 'emp1', 'emp123', 'Finance Department', 'employee'),

('Sunethra Jayasuriya', '23, Main Street, Gampaha', '0769876543', 'sunethra.hr@gov.lk', 'emp2', 'emp123', 'Human Resources', 'employee');


INSERT INTO complaints (user_id, title, description, status, remarks)
VALUES
-- Complaint by emp1 (user_id = 2)
(2, 'Printer not working', 'The finance department printer shows error code 57 and refuses to print.', 'pending', NULL),

-- Complaint by emp2 (user_id = 3)
(3, 'AC not functioning', 'The AC in HR office is broken since last week. Please repair.', 'in-progress', 'Technician assigned.'),

-- Complaint by emp1 (user_id = 2)
(2, 'Network issues', 'Slow internet speed in Finance floor. Difficult to work with email.', 'resolved', 'Issue fixed by IT team on 12th June');
