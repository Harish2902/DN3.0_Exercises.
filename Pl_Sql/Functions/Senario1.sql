CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob IN DATE
) 
RETURN NUMBER
IS
    v_age NUMBER;
BEGIN
    -- Calculate age by comparing the date of birth with the current date
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    
    RETURN v_age;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred while calculating age.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        RETURN NULL;
END CalculateAge;
/
