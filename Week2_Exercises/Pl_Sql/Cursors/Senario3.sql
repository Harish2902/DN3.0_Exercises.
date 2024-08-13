DECLARE
    -- Define the new interest rate policy
    new_interest_rate NUMBER := 4.5; -- New interest rate as a percentage (e.g., 4.5%)

    -- Cursor to fetch all loans
    CURSOR loan_cursor IS
        SELECT LoanID, InterestRate
        FROM Loans;

    -- Record variable for fetching cursor data
    loan_record loan_cursor%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN loan_cursor;

    -- Loop through all loans
    LOOP
        FETCH loan_cursor INTO loan_record;
        EXIT WHEN loan_cursor%NOTFOUND;

        -- Update the interest rate based on the new policy
        UPDATE Loans
        SET InterestRate = new_interest_rate
        WHERE LoanID = loan_record.LoanID;
    END LOOP;

    -- Close the cursor
    CLOSE loan_cursor;

    -- Commit the transaction to make changes persistent
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Print any error that occurs
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        -- Rollback in case of an error
        ROLLBACK;
        -- Ensure cursor is closed
        IF loan_cursor%ISOPEN THEN
            CLOSE loan_cursor;
        END IF;
END;
/
