CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) 
IS
    v_current_salary Employees.Salary%TYPE;
    v_new_salary Employees.Salary%TYPE;
    
BEGIN
    -- Update salaries with bonus in the specified department
    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percentage / 100)
    WHERE Department = p_department;
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Salaries in department ' || p_department || ' have been updated with a bonus of ' || p_bonus_percentage || '%.');
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any errors
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred while updating employee bonuses.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END UpdateEmployeeBonus;
/
