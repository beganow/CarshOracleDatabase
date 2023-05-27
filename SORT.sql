CREATE OR REPLACE FUNCTION SORT_PAYMENTS_BY_DATE RETURN SYS_REFCURSOR AS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        SELECT payment_id, user_id, amount, payment_date
        FROM payments
        ORDER BY payment_date;

    RETURN v_result;
END;

DECLARE
    v_cursor SYS_REFCURSOR;
    v_payment_id NUMBER(10);
    v_user_id NUMBER(10);
    v_amount NUMBER(10, 2);
    v_payment_date DATE;
BEGIN
    v_cursor := SORT_PAYMENTS_BY_DATE;

    LOOP
        FETCH v_cursor INTO v_payment_id, v_user_id, v_amount, v_payment_date;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || v_payment_id);
        DBMS_OUTPUT.PUT_LINE('User ID: ' || v_user_id);
        DBMS_OUTPUT.PUT_LINE('Amount: ' || v_amount);
        DBMS_OUTPUT.PUT_LINE('Payment Date: ' || v_payment_date);
    END LOOP;

    CLOSE v_cursor;
END;
 
 
 CREATE OR REPLACE FUNCTION SORT_CARS_BY_CONDITION RETURN SYS_REFCURSOR AS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        SELECT c.car_id, c.car_brand, c.car_model, c.body_id, c.car_info, c.type_fuel, c.license_plate,
               c.color, c.car_image, c.car_condition, cond.percent_condition
        FROM cars c
        JOIN condition cond ON c.car_condition = cond.condition_id
        ORDER BY cond.percent_condition DESC;

    RETURN v_result;
END;

DECLARE
    v_cursor SYS_REFCURSOR;
    v_car_id NUMBER(10);
    v_car_brand VARCHAR2(20);
    v_car_model VARCHAR2(30);
    v_body_id NUMBER(10);
    v_car_info CLOB;
    v_type_fuel VARCHAR2(20);
    v_license_plate VARCHAR2(20);
    v_color VARCHAR2(20);
    v_car_image BLOB;
    v_car_condition NUMBER(10);
    v_car_percent_condition NUMBER(5,2);
BEGIN
    v_cursor := SORT_CARS_BY_CONDITION;

    LOOP
        FETCH v_cursor INTO v_car_id, v_car_brand, v_car_model, v_body_id, v_car_info, v_type_fuel,
                             v_license_plate, v_color, v_car_image, v_car_condition, v_car_percent_condition;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Car ID: ' || v_car_id);
        DBMS_OUTPUT.PUT_LINE('Car Brand: ' || v_car_brand);
        DBMS_OUTPUT.PUT_LINE('Car Model: ' || v_car_model);
        DBMS_OUTPUT.PUT_LINE('Car Condition: ' || v_car_percent_condition);
        -- Output other retrieved columns
    END LOOP;

    CLOSE v_cursor;
END;
