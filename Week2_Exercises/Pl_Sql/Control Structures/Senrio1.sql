DECLARE
    CURSOR customer_cur IS
        SELECT c.CustomerID, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, c.DOB) / 12) > 60;
        
    v_customer_id Customers.CustomerID%TYPE;
    v_loan_id Loans.LoanID%TYPE;
    v_interest_rate Loans.InterestRate%TYPE;
    
BEGIN
    OPEN customer_cur;
    LOOP
        FETCH customer_cur INTO v_customer_id, v_loan_id, v_interest_rate;
        EXIT WHEN customer_cur%NOTFOUND;
        
        UPDATE Loans
        SET InterestRate = v_interest_rate * 0.99
        WHERE LoanID = v_loan_id;
        
    END LOOP;
    CLOSE customer_cur;
    
    COMMIT;
END;
/