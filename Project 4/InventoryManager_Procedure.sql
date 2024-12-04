CREATE OR REPLACE PROCEDURE update_product_details(
    p_product_id IN NUMBER,
    p_new_price IN NUMBER,
    p_new_quantity IN NUMBER
)
AS
    v_exists NUMBER;
BEGIN
    -- Validate if the product exists
    SELECT COUNT(*)
    INTO v_exists
    FROM Products
    WHERE Product_id = p_product_id;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Product does not exist.');
    END IF;

    -- Update the product details
    UPDATE Products
    SET Price = p_new_price,
        Quantity_in_hand = p_new_quantity
    WHERE Product_id = p_product_id;

    DBMS_OUTPUT.PUT_LINE('Product with ID ' || p_product_id || ' updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE update_order_status(
    p_order_id IN NUMBER,
    p_new_status IN VARCHAR2
)
AS
    v_exists NUMBER;
BEGIN
    -- Validate if the order exists
    SELECT COUNT(*)
    INTO v_exists
    FROM Orders
    WHERE Order_id = p_order_id;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Order does not exist.');
    END IF;

    -- Update the order status
    UPDATE Orders
    SET Order_Status = p_new_status
    WHERE Order_id = p_order_id;

    DBMS_OUTPUT.PUT_LINE('Order with ID ' || p_order_id || ' updated to status: ' || p_new_status);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

