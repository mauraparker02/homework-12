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
VALUES("Administration"); --Pam could go here for receptionist
INSERT INTO department (names) 
VALUES("Receptionist");

USE work_db;

CREATE TABLE roles (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(30) NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  department_id INT(11) NOT NULL,
  PRIMARY KEY (id)
);