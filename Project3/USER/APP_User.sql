
DECLARE
    user_exists NUMBER;
BEGIN
    -- Check if the user exists
    SELECT COUNT(*)
    INTO user_exists
    FROM all_users
    WHERE username = 'APP_USER';

    -- If the user exists, drop it
    IF user_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER APP_USER CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user APP_USER dropped successfully.');
    END IF;

    -- Create the APP_USER
    EXECUTE IMMEDIATE 'CREATE USER APP_USER IDENTIFIED BY "#User2024@Shop"';

    -- Grant basic system privileges
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO APP_USER';

    -- Grant SELECT on Products table (for browsing products)
    EXECUTE IMMEDIATE 'GRANT SELECT ON Products TO APP_USER';

    -- Grant SELECT and INSERT on Orders table (to view and place orders)
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT ON Orders TO APP_USER';

    -- Grant SELECT on Order_Details table (to view order details)
    EXECUTE IMMEDIATE 'GRANT SELECT ON Order_Details TO APP_USER';

    DBMS_OUTPUT.PUT_LINE('User APP_USER created and granted the specified privileges successfully.');
    EXECUTE IMMEDIATE 'GRANT SELECT ON Current_Inventory_Status TO APP_USER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON Customer_Purchase_Behavior TO APP_USER';

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

