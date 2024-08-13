CREATE OR REPLACE PROCEDURE TransferFunds (
    p_source_account_id IN NUMBER,
    p_target_account_id IN NUMBER,
    p_amount IN NUMBER
) 
IS
    v_source_balance Accounts.Balance%TYPE;
    v_target_balance Accounts.Balance%TYPE;
    
    insufficient_funds EXCEPTION;
    invalid_account EXCEPTION;
    PRAGMA EXCEPTION_INIT(insufficient_funds, -20001);
    PRAGMA EXCEPTION_INIT(invalid_account, -20002);

BEGIN
    -- Check if source account and target account are the same
    IF p_source_account_id = p_target_account_id THEN
        RAISE invalid_account;
    END IF;

    -- Check if source account exists and retrieve its balance
    SELECT Balance
    INTO v_source_balance
    FROM Accounts
    WHERE AccountID = p_source_account_id;

    -- Check if target account exists and retrieve its balance
    SELECT Balance
    INTO v_target_balance
    FROM Accounts
    WHERE AccountID = p_target_account_id;
    
    -- Check if the source account has sufficient funds
    IF v_source_balance < p_amount THEN
        RAISE insufficient_funds;
    END IF;

    -- Update balances of source and target accounts
    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_source_account_id;
    
    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_target_account_id;

    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transferred ' || p_amount || ' from account ' || p_source_account_id || ' to account ' || p_target_account_id || '.');
    
EXCEPTION
    WHEN insufficient_funds THEN
        -- Handle the case where the source account does not have sufficient funds
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient funds in account ' || p_source_account_id || '. Transfer aborted.');

    WHEN invalid_account THEN
        -- Handle the case where the source and target accounts are the same
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Source and target accounts are the same. Transfer aborted.');

    WHEN NO_DATA_FOUND THEN
        -- Handle the case where one or both accounts do not exist
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: One or both account IDs do not exist. Transfer aborted.');

    WHEN OTHERS THEN
        -- Handle any other unexpected errors
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred during the fund transfer.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END TransferFunds;
/
