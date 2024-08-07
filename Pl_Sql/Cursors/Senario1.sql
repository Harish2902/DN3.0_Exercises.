DECLARE
    -- Cursor to fetch all transactions for the current month
    CURSOR transaction_cursor IS
        SELECT t.TransactionID, t.AccountID, t.TransactionDate, t.Amount, t.TransactionType, a.CustomerID
        FROM Transactions t
        JOIN Accounts a ON t.AccountID = a.AccountID
        WHERE EXTRACT(MONTH FROM t.TransactionDate) = EXTRACT(MONTH FROM SYSDATE)
          AND EXTRACT(YEAR FROM t.TransactionDate) = EXTRACT(YEAR FROM SYSDATE);

    -- Record variable for fetching cursor data
    transaction_record transaction_cursor%ROWTYPE;

    -- Variable to store the current customer ID
    current_customer_id Accounts.CustomerID%TYPE := NULL;

    -- Variable to accumulate statement details
    statement_details VARCHAR2(4000);
BEGIN
    -- Open the cursor
    OPEN transaction_cursor;

    -- Loop through all transactions
    LOOP
        FETCH transaction_cursor INTO transaction_record;
        EXIT WHEN transaction_cursor%NOTFOUND;

        -- Check if we are processing a new customer
        IF current_customer_id IS NULL OR current_customer_id != transaction_record.CustomerID THEN
            -- Print the statement header for the new customer
            IF current_customer_id IS NOT NULL THEN
                -- Print the accumulated statement details for the previous customer
                DBMS_OUTPUT.PUT_LINE('Customer ID: ' || current_customer_id);
                DBMS_OUTPUT.PUT_LINE(statement_details);
                DBMS_OUTPUT.PUT_LINE('--- End of Statement ---');
                statement_details := NULL; -- Reset for the next customer
            END IF;

            -- Set the current customer ID
            current_customer_id := transaction_record.CustomerID;
        END IF;

        -- Accumulate the transaction details for the current customer
        statement_details := statement_details || 'Transaction ID: ' || transaction_record.TransactionID ||
                             ', Date: ' || TO_CHAR(transaction_record.TransactionDate, 'YYYY-MM-DD') ||
                             ', Amount: ' || transaction_record.Amount ||
                             ', Type: ' || transaction_record.TransactionType || CHR(10);
    END LOOP;

    -- Print the statement for the last customer
    IF current_customer_id IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || current_customer_id);
        DBMS_OUTPUT.PUT_LINE(statement_details);
        DBMS_OUTPUT.PUT_LINE('--- End of Statement ---');
    END IF;

    -- Close the cursor
    CLOSE transaction_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        IF transaction_cursor%ISOPEN THEN
            CLOSE transaction_cursor;
        END IF;
END;
/
