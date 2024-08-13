CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
) 
IS
    v_current_salary Employees.Salary%TYPE;
    v_new_salary Employees.Salary%TYPE;
    
    employee_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(employee_not_found, -20001);
    
BEGIN
    -- Start the transaction
    SAVEPOINT sp_update_salary;
    
    -- Fetch the current salary of the employee
    SELECT Salary INTO v_current_salary
    FROM Employees
    WHERE EmployeeID = p_employee_id;
    
    -- Calculate the new salary
    v_new_salary := v_current_salary * (1 + p_percentage / 100);
    
    -- Update the employee's salary
    UPDATE Employees
    SET Salary = v_new_salary
    WHERE EmployeeID = p_employee_id;
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Salary of employee ID ' || p_employee_id || ' has been updated to ' || v_new_salary || '.');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle the case where the employee ID does not exist
        ROLLBACK TO sp_update_salary;
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_employee_id || ' does not exist. Salary update aborted.');
    
    WHEN OTHERS THEN
        -- Handle any other errors
        ROLLBACK TO sp_update_salary;
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred during the salary update. Update aborted.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END UpdateSalary;
/
