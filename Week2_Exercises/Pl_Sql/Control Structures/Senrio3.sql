DECLARE
    CURSOR loan_cur IS
        SELECT c.CustomerID, c.Name, c.Balance, l.LoanID, l.LoanAmount, l.EndDate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
        
    v_customer_id Customers.CustomerID%TYPE;
    v_name Customers.Name%TYPE;
    v_balance Customers.Balance%TYPE;
    v_loan_id Loans.LoanID%TYPE;
    v_loan_amount Loans.LoanAmount%TYPE;
    v_end_date Loans.EndDate%TYPE;
    
BEGIN
    OPEN loan_cur;
    LOOP
        FETCH loan_cur INTO v_customer_id, v_name, v_balance, v_loan_id, v_loan_amount, v_end_date;
        EXIT WHEN loan_cur%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || v_name || ' (ID: ' || v_customer_id || ') has a loan (ID: ' || v_loan_id || ') due on ' || TO_CHAR(v_end_date, 'YYYY-MM-DD') || '. Loan Amount: ' || v_loan_amount || '.');
        
    END LOOP;
    CLOSE loan_cur;
END;
/
