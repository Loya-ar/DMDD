SET SERVEROUTPUT ON;

DECLARE
    user_exists NUMBER;
BEGIN
    -- Check if the user exists
    SELECT COUNT(*)
    INTO user_exists
    FROM all_users
    WHERE username = 'STOCK_CONTROL_2024';

    -- If the user exists, drop it
    IF user_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER STOCK_CONTROL_2024 CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user STOCK_CONTROL_2024 dropped successfully.');
    END IF;

    -- Create the STOCK_CONTROL_2024 user
    EXECUTE IMMEDIATE 'CREATE USER STOCK_CONTROL_2024 IDENTIFIED BY "#StockControl2024@Inventory"';

    -- Grant basic system privileges
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO STOCK_CONTROL_2024';

    -- Grant specific access to manage storage (quota) on the USERS tablespace
    EXECUTE IMMEDIATE 'ALTER USER STOCK_CONTROL_2024 QUOTA 10M ON USERS';

    -- Grant limited privileges on Products table
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON Products TO STOCK_CONTROL_2024';

    -- Grant SELECT and limited UPDATE on Orders table
    EXECUTE IMMEDIATE 'GRANT SELECT ON Orders TO STOCK_CONTROL_2024';
    EXECUTE IMMEDIATE 'GRANT UPDATE (Order_Status) ON Orders TO STOCK_CONTROL_2024';

    -- Grant SELECT on Order_Details table and views
    EXECUTE IMMEDIATE 'GRANT SELECT ON Order_Details TO STOCK_CONTROL_2024';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Current_Inventory_Status TO STOCK_CONTROL_2024';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Total_Sales_Region TO STOCK_CONTROL_2024';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Order_Fulfillment_Status TO STOCK_CONTROL_2024';

    DBMS_OUTPUT.PUT_LINE('User STOCK_CONTROL_2024 created and granted the specified limited privileges successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
