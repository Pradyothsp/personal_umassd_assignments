SELECT Fname, Minit, Lname
FROM EMPLOYEE
LEFT JOIN WORKS_ON ON EMPLOYEE.Ssn = WORKS_ON.Essn
WHERE Dno=5 AND Hours > 10 AND Pno = 1;


SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Dno=5 AND Ssn in (SELECT distinct (Essn) from WORKS_ON where  Hours > 10 AND Pno = 1);


SELECT Fname, Minit, Lname, Dependent_name
FROM EMPLOYEE
LEFT JOIN DEPENDENT ON EMPLOYEE.Ssn = DEPENDENT.Essn
WHERE Dependent_name = Fname;


SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Super_ssn = 123456789;

SELECT EMP2.Fname, EMP2.Minit, EMP2.Lname
FROM EMPLOYEE EMP1
LEFT JOIN EMPLOYEE EMP2 ON EMP2.Super_ssn = EMP1.Ssn
WHERE CONCAT(EMP1.Fname,' ',EMP1.Lname) = 'John Smith';
