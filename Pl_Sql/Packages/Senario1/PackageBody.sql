CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    -- Implementation of procedure to add a new customer
    PROCEDURE AddNewCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE,
        p_Balance IN NUMBER
    ) IS
    BEGIN
        BEGIN
            -- Try to insert a new customer
            INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
            VALUES (p_CustomerID, p_Name, p_DOB, p_Balance, SYSDATE);
            
            -- Commit the transaction
            COMMIT;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                -- Handle duplicate key error
                DBMS_OUTPUT.PUT_LINE('Error: Customer with ID ' || p_CustomerID || ' already exists.');
        END;
    END AddNewCustomer;

    -- Implementation of procedure to update customer details
    PROCEDURE UpdateCustomerDetails(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Balance IN NUMBER
    ) IS
    BEGIN
        BEGIN
            -- Update customer details
            UPDATE Customers
            SET Name = p_Name, Balance = p_Balance, LastModified = SYSDATE
            WHERE CustomerID = p_CustomerID;
            
            -- Commit the transaction
            COMMIT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle case where customer ID does not exist
                DBMS_OUTPUT.PUT_LINE('Error: Customer with ID ' || p_CustomerID || ' does not exist.');
        END;
    END UpdateCustomerDetails;

    -- Implementation of function to get customer balance
    FUNCTION GetCustomerBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER IS
        v_Balance NUMBER;
    BEGIN
        BEGIN
            -- Fetch the customer balance
            SELECT Balance INTO v_Balance
            FROM Customers
            WHERE CustomerID = p_CustomerID;

            RETURN v_Balance;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Handle case where customer ID does not exist
                DBMS_OUTPUT.PUT_LINE('Error: Customer with ID ' || p_CustomerID || ' does not exist.');
                RETURN NULL;
        END;
    END GetCustomerBalance;

END CustomerManagement;
/
