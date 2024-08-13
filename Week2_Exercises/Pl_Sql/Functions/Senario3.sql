CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,
    p_amount IN NUMBER
) 
RETURN BOOLEAN
IS
    v_balance NUMBER;
BEGIN
    -- Fetch the current balance of the specified account
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;

    -- Check if the balance is sufficient
    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where account ID does not exist
        RETURN FALSE;
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred while checking the balance.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        RETURN FALSE;
END HasSufficientBalance;
/
