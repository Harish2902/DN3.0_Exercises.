DECLARE
    -- Define the annual fee amount
    annual_fee NUMBER := 50; -- Adjust the fee amount as necessary

    -- Cursor to fetch all accounts
    CURSOR account_cursor IS
        SELECT AccountID, Balance
        FROM Accounts;

    -- Record variable for fetching cursor data
    account_record account_cursor%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN account_cursor;

    -- Loop through all accounts
    LOOP
        FETCH account_cursor INTO account_record;
        EXIT WHEN account_cursor%NOTFOUND;

        -- Check if the account has sufficient balance to apply the fee
        IF account_record.Balance >= annual_fee THEN
            -- Deduct the annual fee from the account balance
            UPDATE Accounts
            SET Balance = Balance - annual_fee
            WHERE AccountID = account_record.AccountID;
        ELSE
            -- Optionally, handle accounts with insufficient balance
            DBMS_OUTPUT.PUT_LINE('Account ID ' || account_record.AccountID || ' has insufficient balance for fee application.');
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE account_cursor;

    -- Commit the transaction to make changes persistent
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Print any error that occurs
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        -- Rollback in case of an error
        ROLLBACK;
        -- Ensure cursor is closed
        IF account_cursor%ISOPEN THEN
            CLOSE account_cursor;
        END IF;
END;
/
