const inquirer = require('inquirer');
var mysql = require('mysql2');
const cTable = require('console.table');

var connection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "passwordisroot",
    database: "work_db"
});

connection.connect(function (err) {
    if (err) throw err;
    askUser();
});

function askUser() {
    inquirer
        .prompt([{
            type: 'list',
            message: 'What is your job?',
            name: 'choice',
            choices: ['View All Employees', 'View All Roles', 'View by Department', 'Add Employee', 'Update Employee Role', 'Remove Employee', 'Done']
        }]).then(function (response) {
            if (response.choice === 'View All Employees') {
                viewEmployees();
            } else if (response.choice === 'View by Department') {
                viewByDepartment();
            } else if (response.choice === 'View All Roles') {
                viewRoles();
            } else if (response.choice === 'Add Employee') {
                addEmployee();
            } else if (response.choice === 'Remove Employee') {
                removeEmployee();
            } else if (response.choice === 'Update Employee Role') {
                updateRole();
            } else if (response.choice === 'Done') {
                connection.end();
                console.log("Application has ended.")
            }
        })
}

function viewEmployees() {
    connection.query('SELECT * FROM employee LEFT JOIN (roles, department) ON (roles.id = employee.role_id AND department.id = roles.department_id)', function (err, data) {
        if (err) throw err;
        console.table(data);
        askUser();
    });
}

function viewByDepartment() {
    inquirer.prompt([
        {   type: 'input',
            message: 'What is the id for your department? 1-Manager, 2-HumanResources, 3-Sales, 4-Accounting, 5-Administration',
            name: 'id',
        }  
    ]).then(data=>{
        connection.query(`SELECT * FROM employee LEFT JOIN (roles, department) ON (roles.id = employee.role_id AND department.id = roles.department_id) WHERE department.id = ${data.id}`, function (err, data) {
            if (err) throw err;
            console.table(data);
            askUser();
        });
    })  
}

function viewRoles() {
    connection.query('SELECT employee.first_name, employee.last_name, roles.title FROM employee, roles WHERE roles.id=employee.role_id', function (err, data) {
        if (err) throw err;
        console.table(data);
        askUser();
    });
}

function addEmployee() {
    inquirer.prompt([
        {   type: 'input',
            message: 'What is the FIRST name of the employee?',
            name: 'first_name',
        },
        {   type: 'input',
            message: 'What is the LAST name of the employee?',
            name: 'last_name',
        },
        {   type: 'input',
            message: 'What is the role of the employee? 1-Manager, 2-Human Resources, 3-Sales, 4-Accounting, 5-Administration',
            name: 'role',
        }  
    ]).then(data=>{
        connection.query(`INSERT INTO employee (first_name, last_name, role_id, manager_id) VALUES('${data.first_name}', '${data.last_name}', ${data.role}, 1);`, function(err, data){ 
        if (err) throw err;
        console.table(data);
        console.log("Successful")
        askUser()
    })
    })  
}

function removeEmployee() {
        inquirer.prompt([
            {   type: 'input',
                message: 'What is the LAST name of the employee you want to remove?',
                name: 'lastName',
            }  
        ]).then(data => {
            connection.query(`DELETE FROM employee WHERE last_name='${data.lastName}'`, function(err, data){
            if (err) throw err;
            console.table(data);
            console.log("Successfully Removed Employee!")
            askUser()
        });
    })
}

function updateRole() {
    inquirer.prompt([
    {
        type: 'input',
        message: 'What is the new title for your employee? 1-Manager, 2-Human Resources, 3-Sales, 4-Accounting, 5-Administration',
        name: 'title',
    },
    {
        type: 'input',
        message: 'What is the LAST name of your employee?',
        name: 'id',
    },
]).then(data => {
        connection.query(`UPDATE employee SET role_id='${data.title}' WHERE last_name='${data.id}'`, function (err, data) {
            if (err) throw err;
            console.table(data);
            console.log("Successful Changed Role!")
            askUser()
        });
    })
}