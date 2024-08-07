CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    -- Implementation of procedure to hire a new employee
    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    ) IS
    BEGIN
        BEGIN
            -- Insert a new employee record
            INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
            VALUES (p_EmployeeID, p_Name, p_Position, p_Salary, p_Department, p_HireDate);
            
            -- Commit the transaction
            COMMIT;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                -- Handle duplicate employee ID error
                DBMS_OUTPUT.PUT_LINE('Error: Employee with ID ' || p_EmployeeID || ' already exists.');
        END;
    END HireEmployee;

    -- Implementation of procedure to update employee details
    PROCEDURE UpdateEmployeeDetails(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Position IN VARCHAR2,
        p_Department IN VARCHAR2
    ) IS
    BEGIN
        BEGIN
            -- Update employee details
            UPDATE Employees
            SET Name = p_Name, Salary = p_Salary, Position = p_Position, Department = p_Department
            WHERE EmployeeID = p_EmployeeID;
            
            -- Commit the transaction
            COMMIT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle case where employee ID does not exist
                DBMS_OUTPUT.PUT_LINE('Error: Employee with ID ' || p_EmployeeID || ' does not exist.');
        END;
    END UpdateEmployeeDetails;

    -- Implementation of function to calculate annual salary
    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER IS
        v_Salary NUMBER;
    BEGIN
        BEGIN
            -- Fetch the employee salary
            SELECT Salary INTO v_Salary
            FROM Employees
            WHERE EmployeeID = p_EmployeeID;

            -- Return the annual salary
            RETURN v_Salary * 12;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle case where employee ID does not exist
                DBMS_OUTPUT.PUT_LINE('Error: Employee with ID ' || p_EmployeeID || ' does not exist.');
                RETURN NULL;
        END;
    END CalculateAnnualSalary;

END EmployeeManagement;
/
