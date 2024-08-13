
 DECLARE
     CURSOR customer_cur IS
         SELECT CustomerID, Balance
         FROM Customers;
         
     v_customer_id Customers.CustomerID%TYPE;
     v_balance Customers.Balance%TYPE;
     
 BEGIN
     OPEN customer_cur;
     LOOP
         FETCH customer_cur INTO v_customer_id, v_balance;
         EXIT WHEN customer_cur%NOTFOUND;
         
         IF v_balance > 10000 THEN
             UPDATE Customers
             SET IsVIP = 'TRUE'
             WHERE CustomerID = v_customer_id;
         ELSE
             UPDATE Customers
             SET IsVIP = 'FALSE'
             WHERE CustomerID = v_customer_id;
         END IF;
         
     END LOOP;
     CLOSE customer_cur;
     
     COMMIT;
 END;
 /