/*
 *   Create database and initialize database table structure
 */
CREATE DATABASE sqljoinshw;
\c sqljoinshw;

CREATE TABLE employees
(
    ssn           VARCHAR(11) PRIMARY KEY,
    first         VARCHAR(255),
    last          VARCHAR(255),
    year_of_birth Date,
    city          VARCHAR(50)
);

CREATE TABLE jobs
(
    ssn        VARCHAR(50),
    company    VARCHAR(50),
    salary     INTEGER,
    experience INTEGER
);

ALTER TABLE job
    ADD CONSTRAINT fk_employee_ssn
        FOREIGN KEY (ssn)
            REFERENCES employee (ssn);
/*
 * Insert data into tables
 */
\COPY employees FROM '/Users/ghazanfar/Documents/General_Assembly/java/databases/sql-joins-lab/starter-code/employees.csv'  DELIMITER ',' CSV;

\COPY jobs FROM '/Users/ghazanfar/Documents/General_Assembly/java/databases/sql-joins-lab/starter-code/jobs.csv'  DELIMITER ',' CSV;


/*
 *  Employees working at macys
 */
SELECT *
FROM employee
         JOIN job
              ON employee.ssn = job.ssn
WHERE job.company LIKE 'Macy%';

/*
 *  Companies in Boston
 */
SELECT compnay
FROM employee
         JOIN job
              ON employee.ssn = job.ssn
WHERE employee.city = 'Boston';

/*
 *  Employee with the highest salary
 */
SELECT employee
FROM employee
         JOIN job
              ON employee.ssn = job.ssn
WHERE job.salary = (
    SELECT max(salary)
    FROM job
);
