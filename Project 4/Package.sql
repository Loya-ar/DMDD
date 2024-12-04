CREATE OR REPLACE PACKAGE project_mgmt AS

  -- Procedure to place an order
  PROCEDURE place_order(
    p_user_email IN VARCHAR2,
    p_product_id IN NUMBER,
    p_quantity IN NUMBER,
    o_order_id OUT NUMBER
  );

  -- Procedure to upsert user details
  PROCEDURE upsert_user_details(
    p_user_first_name IN VARCHAR2,
    p_user_last_name IN VARCHAR2,
    p_user_email IN VARCHAR2,
    p_user_location IN VARCHAR2
  );

  -- Function to calculate total order amount
  FUNCTION calculate_order_total(
    f_order_id IN NUMBER,
    f_tax IN NUMBER,
    f_delivery_charge IN NUMBER
  ) RETURN NUMBER;

END project_mgmt;
/

CREATE OR REPLACE PACKAGE BODY project_mgmt AS

  -- Procedure to place an order
  PROCEDURE place_order(
    p_user_email IN VARCHAR2,
    p_product_id IN NUMBER,
    p_quantity IN NUMBER,
    o_order_id OUT NUMBER
  ) IS
    v_user_id NUMBER;
    v_price_per_unit NUMBER;
    v_total_price NUMBER;
    v_quantity_in_hand NUMBER;
  BEGIN
    -- Fetch the user ID based on email
    SELECT User_id INTO v_user_id 
    FROM Users 
    WHERE Email = p_user_email;

    -- Fetch the product price and available quantity
    SELECT Price, Quantity_in_hand INTO v_price_per_unit, v_quantity_in_hand 
    FROM Products 
    WHERE Product_id = p_product_id;

    -- Validate the inventory
    IF v_quantity_in_hand < p_quantity THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient inventory for the requested product.');
    END IF;

    -- Calculate the total price
    v_total_price := v_price_per_unit * p_quantity;

    -- Insert a new order into the Orders table
    INSERT INTO Orders (User_id, Total_Price, Order_Status)
    VALUES (v_user_id, v_total_price, 'Pending')
    RETURNING Order_id INTO o_order_id;

    -- Insert order details into the Order_Details table
    INSERT INTO Order_Details (Order_id, Product_id, Quantity, Price_Per_Unit)
    VALUES (o_order_id, p_product_id, p_quantity, v_price_per_unit);

    -- Update the product inventory
    UPDATE Products
    SET Quantity_in_hand = Quantity_in_hand - p_quantity
    WHERE Product_id = p_product_id;

    DBMS_OUTPUT.PUT_LINE('Order placed successfully. Order ID: ' || o_order_id);
  END;

  -- Procedure to upsert user details
  PROCEDURE upsert_user_details(
    p_user_first_name IN VARCHAR2,
    p_user_last_name IN VARCHAR2,
    p_user_email IN VARCHAR2,
    p_user_location IN VARCHAR2
  ) IS
    v_user_id NUMBER;
    v_user_exists NUMBER;
  BEGIN
    -- Check if the user already exists
    SELECT COUNT(*) INTO v_user_exists 
    FROM Users 
    WHERE Email = p_user_email;

    IF v_user_exists > 0 THEN
      -- If the user exists, update their details
      UPDATE Users
      SET First_Name = p_user_first_name,
          Last_Name = p_user_last_name,
          Location = p_user_location
      WHERE Email = p_user_email;

      DBMS_OUTPUT.PUT_LINE('User details updated successfully.');
    ELSE
      -- If the user does not exist, insert a new record
      INSERT INTO Users (First_Name, Last_Name, Email, Location)
      VALUES (p_user_first_name, p_user_last_name, p_user_email, p_user_location);

      DBMS_OUTPUT.PUT_LINE('New user added successfully.');
    END IF;
  END;

  -- Function to calculate total order amount
  FUNCTION calculate_order_total(
    f_order_id IN NUMBER,
    f_tax IN NUMBER,
    f_delivery_charge IN NUMBER
  ) RETURN NUMBER IS
    v_total_price NUMBER;
  BEGIN
    -- Calculate the total cost of all products in the order
    SELECT SUM(Quantity * Price_Per_Unit) INTO v_total_price
    FROM Order_Details
    WHERE Order_id = f_order_id;

    -- Add tax and delivery charges to the total price
    RETURN v_total_price + f_tax + f_delivery_charge;
  END;

END project_mgmt;
/
