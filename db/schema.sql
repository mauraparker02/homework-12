DROP DATABASE IF EXISTS work_db;

CREATE DATABASE work_db;

USE work_db;

CREATE TABLE department (
  id INT NOT NULL AUTO_INCREMENT,
  names VARCHAR(30) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO department (names) 
VALUES("Manager");
INSERT INTO department (names) 
VALUES("Human Resources");
INSERT INTO department (names) 
VALUES("Sales");
INSERT INTO department (names) 
VALUES("Accounting");
INSERT INTO department (names) 
VALUES("Administration"); 


USE work_db;

CREATE TABLE roles (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(30) NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  department_id INT(11) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO roles (title, salary, department_id) 
VALUES("Manager", 65000, 1);
INSERT INTO roles (title, salary, department_id) 
VALUES("Human Resources", 33000, 2);
INSERT INTO roles (title, salary, department_id) 
VALUES("Sales", 45000, 3);
INSERT INTO roles (title, salary, department_id) 
VALUES("Accounting", 45000, 4);
INSERT INTO roles (title, salary, department_id) 
VALUES("Administration", 15000, 5);
INSERT INTO roles (title, salary, department_id) 
VALUES("Reception", 15000, 5);

USE work_db;

CREATE TABLE employee (
  id INT NOT NULL AUTO_INCREMENT, 
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  role_id INT(11) NOT NULL,
  manager_id INT(11) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Michael", "Scott", 1, 1);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Dwight", "Schrute", 2, 3);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Jim", "Halpert", 3, 3);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Pam", "Beesly", 4, 5);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Stanley", "Hudson", 5, 4);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Kevin", "Malone", 6, 4);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Kelly", "Kapoor", 7, 2);
INSERT INTO employee (first_name, last_name, role_id, manager_id) 
VALUES("Toby", "Flenderson", 8, 2);

SELECT * FROM employee LEFT JOIN (roles, department)
ON (roles.id = employee.role_id AND department.id = roles.department_id);

SELECT * FROM employee LEFT JOIN (roles, department) 
ON (roles.id = employee.role_id AND department.id = roles.department_id)
WHERE department.id = 2;