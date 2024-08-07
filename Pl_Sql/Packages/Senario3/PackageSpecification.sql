CREATE OR REPLACE PACKAGE AccountOperations AS
    -- Procedure to open a new account
    PROCEDURE OpenAccount(
        p_AccountID IN NUMBER,
        p_CustomerID IN NUMBER,
        p_AccountType IN VARCHAR2,
        p_Balance IN NUMBER,
        p_LastModified IN DATE
    );

    -- Procedure to close an account
    PROCEDURE CloseAccount(
        p_AccountID IN NUMBER
    );

    -- Function to get the total balance of a customer across all accounts
    FUNCTION GetTotalBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/
