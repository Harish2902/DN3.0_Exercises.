CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    -- Insert a record into the AuditLog table
    INSERT INTO AuditLog (LogID, TransactionID, AuditDate, Action, Details)
    VALUES (
        AuditLog_seq.NEXTVAL,          -- Assuming you have a sequence for generating LogID
        :NEW.TransactionID,
        SYSDATE,
        'INSERT',
        'Transaction ID: ' || :NEW.TransactionID || ', Amount: ' || :NEW.Amount || ', Type: ' || :NEW.TransactionType
    );
END;
/
	