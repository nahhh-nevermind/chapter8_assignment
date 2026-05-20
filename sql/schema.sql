CREATE DATABASE IF NOT EXISTS employee_records
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE employee_records;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empId VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(120) NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(120) NOT NULL,
    hireDate DATE NOT NULL,
    salary  DECIMAL(10,2) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
)ENGINE=InnoDB;

INSERT INTO employees (empId, name, email, department, position, hireDate, salary, active)
VALUES
('EMP001', 'Kim Dohoon', 'Dohoon.Kim@yahoo.com', 'HR', 'Secretary', '2025-01-01', 2000.00, 1),
('EMP002', 'Sarah Lee', 'sarah.lee@company.com', 'IT', 'Developer', '2025-03-15', 4500.00, 1),
('EMP003', 'John Smith', 'john.smith@company.com', 'Finance', 'Analyst', '2024-06-01', 5000.00, 1),
('EMP004', 'Amina Ibrahim', 'amina.i@company.com', 'HR', 'Manager', '2023-01-10', 8000.00, 1),
('EMP005', 'Chen Wei', 'wei.chen@company.com', 'IT', 'SysAdmin', '2025-11-20', 4200.00, 0),
('EMP006', 'Muthu Velu', 'muthu.v@company.com', 'Marketing', 'Executive', '2026-02-01', 3200.00, 1),
('EMP007', 'Lisa Wong', 'lisa.w@company.com', 'Operations', 'Coordinator', '2024-09-15', 3800.00, 0);
