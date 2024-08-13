CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_customer_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER
) 
IS
    v_existing_customer_count NUMBER;
    
    customer_exists EXCEPTION;
    PRAGMA EXCEPTION_INIT(customer_exists, -20001);
    
BEGIN
    -- Check if a customer with the same ID already exists
    SELECT COUNT(*)
    INTO v_existing_customer_count
    FROM Customers
    WHERE CustomerID = p_customer_id;
    
    IF v_existing_customer_count > 0 THEN
        RAISE customer_exists;
    END IF;
    
    -- Insert the new customer
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE);
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Customer with ID ' || p_customer_id || ' has been added successfully.');
    
EXCEPTION
    WHEN customer_exists THEN
        -- Handle the case where the customer ID already exists
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Customer with ID ' || p_customer_id || ' already exists. Insertion aborted.');
    
    WHEN OTHERS THEN
        -- Handle any other errors
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred while adding the customer. Insertion aborted.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END AddNewCustomer;
/
