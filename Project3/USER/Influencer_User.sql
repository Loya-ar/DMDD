
DECLARE
    user_exists NUMBER;
BEGIN
    -- Check if the user exists
    SELECT COUNT(*)
    INTO user_exists
    FROM all_users
    WHERE username = 'INFLUENCER_USER';

    -- If the user exists, drop it
    IF user_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER INFLUENCER_USER CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user INFLUENCER_USER dropped successfully.');
    END IF;

    -- Create the INFLUENCER_USER
    EXECUTE IMMEDIATE 'CREATE USER INFLUENCER_USER IDENTIFIED BY "#Influencer2024@Promote"';

    -- Grant basic system privileges
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO INFLUENCER_USER';

    -- Grant SELECT on Products table (to view products)
    EXECUTE IMMEDIATE 'GRANT SELECT ON Products TO INFLUENCER_USER';

    DBMS_OUTPUT.PUT_LINE('User INFLUENCER_USER created and granted the specified privileges successfully.');
    
     EXECUTE IMMEDIATE 'GRANT SELECT ON Influencer_Sales_Performance TO INFLUENCER_USER';
     EXECUTE IMMEDIATE 'GRANT SELECT ON Current_Inventory_Status TO INFLUENCER_USER';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
