CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_source_account_id IN NUMBER,
    p_target_account_id IN NUMBER,
    p_amount IN NUMBER
) 
IS
    v_source_balance Accounts.Balance%TYPE;
    v_target_balance Accounts.Balance%TYPE;
    
    insufficient_funds EXCEPTION;
    PRAGMA EXCEPTION_INIT(insufficient_funds, -20001);
    
BEGIN
    -- Start the transaction
    SAVEPOINT sp_transfer;
    
    -- Get the balance of the source account
    SELECT Balance INTO v_source_balance
    FROM Accounts
    WHERE AccountID = p_source_account_id
    FOR UPDATE;
    
    -- Check if the source account has sufficient funds
    IF v_source_balance < p_amount THEN
        RAISE insufficient_funds;
    END IF;
    
    -- Get the balance of the target account
    SELECT Balance INTO v_target_balance
    FROM Accounts
    WHERE AccountID = p_target_account_id
    FOR UPDATE;
    
    -- Perform the transfer
    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_source_account_id;
    
    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_target_account_id;
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_amount || ' from account ' || p_source_account_id || ' to account ' || p_target_account_id || ' completed successfully.');
    
EXCEPTION
    WHEN insufficient_funds THEN
        -- Handle insufficient funds error
        ROLLBACK TO sp_transfer;
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient funds in source account ' || p_source_account_id || '. Transfer aborted.');
    
    WHEN OTHERS THEN
        -- Handle any other errors
        ROLLBACK TO sp_transfer;
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred during the transfer. Transfer aborted.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END SafeTransferFunds;
/
