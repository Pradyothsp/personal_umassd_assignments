CREATE PROCEDURE insert_employee(
IN Fname VARCHAR(15),
IN Minit CHAR,
IN Lname VARCHAR(15),
IN Ssn CHAR(9),
IN Bdate DATE,
IN Address VARCHAR(30),
IN Sex CHAR,
IN Salary DECIMAL(10, 2),
IN Super_ssn CHAR(9),
IN Dno INT
)

BEGIN
    INSERT INTO EMPLOYEE VALUES (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno);
END;


call insert_employee(
     'Narendra',
     'D',
     'Modi',
     '123454321',
     '1950-09-17',
     '7, Lok Kalyan Marg, New Delhi',
     'M',
     '280000',
     '432151234',
     '1'
    );


call insert_employee(
     'VARUN',
     'W',
     'R',
     '123454320',
     '1996-10-20',
     '7, 57, Foster Street',
     'M',
     '600000',
     '432151234',
     '2'
    );
