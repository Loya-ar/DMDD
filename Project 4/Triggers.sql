--Trigger 1: Update Inventory After an Order is Placed

CREATE OR REPLACE TRIGGER Update_Inventory_After_Order
AFTER INSERT ON Order_Details
FOR EACH ROW
DECLARE
    v_quantity_in_hand NUMBER;
BEGIN
    -- Fetch current inventory for the product
    SELECT Quantity_in_hand 
    INTO v_quantity_in_hand 
    FROM Products 
    WHERE Product_id = :NEW.Product_id;

    -- Check if sufficient stock is available
    IF v_quantity_in_hand < :NEW.Quantity THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for the product.');
    END IF;

    -- Update the product inventory
    UPDATE Products
    SET Quantity_in_hand = Quantity_in_hand - :NEW.Quantity
    WHERE Product_id = :NEW.Product_id;
END;
/
--Trigger 2: Prevent Out-of-Stock Products from Being Ordered

CREATE OR REPLACE TRIGGER Prevent_Out_Of_Stock_Order
BEFORE INSERT ON Order_Details
FOR EACH ROW
DECLARE
    v_quantity_in_hand NUMBER;
BEGIN
    -- Fetch the current quantity in hand for the product
    SELECT Quantity_in_hand 
    INTO v_quantity_in_hand 
    FROM Products 
    WHERE Product_id = :NEW.Product_id;

    -- Ensure sufficient stock
    IF v_quantity_in_hand < :NEW.Quantity THEN
        RAISE_APPLICATION_ERROR(-20002, 'Product is out of stock and cannot be ordered.');
    END IF;
END;
/

--Trigger 3: Prevent Negative Inventory Levels

CREATE OR REPLACE TRIGGER Prevent_Negative_Inventory
BEFORE UPDATE OF Quantity_in_hand ON Products
FOR EACH ROW
BEGIN
    -- Ensure the new quantity is not negative
    IF :NEW.Quantity_in_hand < 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Quantity cannot be negative.');
    END IF;
END;
/















