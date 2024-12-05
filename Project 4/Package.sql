CREATE OR REPLACE PACKAGE project_mgmt AS

  -- Procedure to place an order
  PROCEDURE place_orde(
    p_user_email IN VARCHAR2,
    p_product_id IN NUMBER,
    p_quantity IN NUMBER,
    p_influencer_id IN NUMBER,
    o_order_id OUT NUMBER
  );

  -- Procedure to upsert product inventory
  PROCEDURE update_product_inventory(
    p_product_id IN NUMBER,
    p_quantity_change IN NUMBER
  );

  -- Procedure to update order status
  PROCEDURE update_order_status(
    p_order_id IN NUMBER,
    p_new_status IN VARCHAR2
  );

END project_mgmt;
/

CREATE OR REPLACE PACKAGE BODY project_mgmt AS

  -- Procedure to place an order
  PROCEDURE place_order(
    p_user_email IN VARCHAR2,
    p_product_id IN NUMBER,
    p_quantity IN NUMBER,
    p_influencer_id IN NUMBER,
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

  -- Procedure to update product inventory
  PROCEDURE update_product_inventory(
    p_product_id IN NUMBER,
    p_quantity_change IN NUMBER
  ) IS
  BEGIN
    -- Update the product inventory
    UPDATE Products
    SET Quantity_in_hand = Quantity_in_hand + p_quantity_change
    WHERE Product_id = p_product_id;

    DBMS_OUTPUT.PUT_LINE('Product inventory updated successfully.');
  END;

  -- Procedure to update order status
  PROCEDURE update_order_status(
    p_order_id IN NUMBER,
    p_new_status IN VARCHAR2
  ) IS
  BEGIN
    -- Update the status of the order
    UPDATE Orders
    SET Order_Status = p_new_status
    WHERE Order_id = p_order_id;

    DBMS_OUTPUT.PUT_LINE('Order status updated successfully.');
  END;

END project_mgmt;
/
