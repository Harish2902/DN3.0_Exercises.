CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
    v_interest_rate NUMBER := 0.01; -- 1% interest rate
BEGIN
    -- Update balances of all savings accounts with interest applied
    UPDATE Accounts
    SET Balance = Balance * (1 + v_interest_rate)
    WHERE AccountType = 'Savings';
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Monthly interest has been applied to all savings accounts.');
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any errors
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred while processing monthly interest.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ProcessMonthlyInterest;
/
