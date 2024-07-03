-- script_bd_company.sql

CREATE TABLE IF NOT EXISTS employee(
    Fname TEXT NOT NULL,
    Minit TEXT,
    Lname TEXT NOT NULL,
    Ssn TEXT NOT NULL PRIMARY KEY, 
    Bdate TEXT,
    Address TEXT,
    Sex TEXT,
    Salary REAL,
    Super_ssn TEXT,
    Dno INTEGER NOT NULL DEFAULT 1,
    CHECK (Salary > 2000.0)
);

CREATE TABLE IF NOT EXISTS department(
    Dname TEXT NOT NULL UNIQUE,
    Dnumber INTEGER NOT NULL PRIMARY KEY,
    Mgr_ssn TEXT NOT NULL,
    Mgr_start_date TEXT, 
    Dept_create_date TEXT,
    CHECK (Dept_create_date < Mgr_start_date),
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS dept_locations(
    Dnumber INTEGER NOT NULL,
    Dlocation TEXT NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES department (Dnumber) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS project(
    Pname TEXT NOT NULL UNIQUE,
    Pnumber INTEGER NOT NULL PRIMARY KEY,
    Plocation TEXT,
    Dnum INTEGER NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES department(Dnumber)
);

CREATE TABLE IF NOT EXISTS works_on(
    Essn TEXT NOT NULL,
    Pno INTEGER NOT NULL,
    Hours REAL NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

CREATE TABLE IF NOT EXISTS dependent(
    Essn TEXT NOT NULL,
    Dependent_name TEXT NOT NULL,
    Sex TEXT,
    Bdate TEXT,
    Relationship TEXT,
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);