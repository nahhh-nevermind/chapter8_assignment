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
('EMP001', 'Kim Dohoon', 'Dohoon.Kim@yahoo.com', 'HR', 'Secretary', '2025-01-01', 2000.00, 1);
