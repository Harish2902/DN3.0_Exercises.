CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    -- Implementation of procedure to open a new account
    PROCEDURE OpenAccount(
        p_AccountID IN NUMBER,
        p_CustomerID IN NUMBER,
        p_AccountType IN VARCHAR2,
        p_Balance IN NUMBER,
        p_LastModified IN DATE
    ) IS
    BEGIN
        BEGIN
            -- Insert a new account record
            INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
            VALUES (p_AccountID, p_CustomerID, p_AccountType, p_Balance, p_LastModified);
            
            -- Commit the transaction
            COMMIT;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                -- Handle duplicate account ID error
                DBMS_OUTPUT.PUT_LINE('Error: Account with ID ' || p_AccountID || ' already exists.');
        END;
    END OpenAccount;

    -- Implementation of procedure to close an account
    PROCEDURE CloseAccount(
        p_AccountID IN NUMBER
    ) IS
    BEGIN
        BEGIN
            -- Delete the account record
            DELETE FROM Accounts
            WHERE AccountID = p_AccountID;
            
            -- Commit the transaction
            COMMIT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle case where account ID does not exist
                DBMS_OUTPUT.PUT_LINE('Error: Account with ID ' || p_AccountID || ' does not exist.');
        END;
    END CloseAccount;

    -- Implementation of function to get the total balance of a customer across all accounts
    FUNCTION GetTotalBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER IS
        v_TotalBalance NUMBER;
    BEGIN
        BEGIN
            -- Fetch the total balance for the customer
            SELECT SUM(Balance) INTO v_TotalBalance
            FROM Accounts
            WHERE CustomerID = p_CustomerID;
            
            -- If no accounts are found, return 0
            IF v_TotalBalance IS NULL THEN
                v_TotalBalance := 0;
            END IF;

            RETURN v_TotalBalance;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle case where customer ID does not exist
                DBMS_OUTPUT.PUT_LINE('Error: No accounts found for Customer ID ' || p_CustomerID || '.');
                RETURN 0;
        END;
    END GetTotalBalance;

END AccountOperations;
/
