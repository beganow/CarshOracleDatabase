CREATE OR REPLACE FUNCTION SEARCH_CARS_BY_PRICE (
    p_min_price NUMBER,
    p_max_price NUMBER
) RETURN SYS_REFCURSOR AS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        SELECT c.car_id, c.car_brand, c.car_model, c.body_id, c.car_info, c.type_fuel, c.Adress,
               c.license_plate, c.color, c.car_image, c.car_condition, p.price_per_min,
               p.count_min, p.total_price
        FROM cars c
        JOIN pricing p ON c.car_id = p.car_id
        WHERE p.price_per_min BETWEEN p_min_price AND p_max_price;

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
    v_price_per_min NUMBER(10,2);
    v_count_min NUMBER(10);
    v_adress VARCHAR2(50);
    v_total_price NUMBER(10);
BEGIN
    v_cursor := SEARCH_CARS_BY_PRICE(p_min_price => 1, p_max_price => 50);

    LOOP
        FETCH v_cursor INTO v_car_id, v_car_brand, v_car_model, v_body_id, v_car_info, v_type_fuel,  v_adress,
                             v_license_plate, v_color, v_car_image, v_car_condition, v_price_per_min,
                             v_count_min, v_total_price;
        EXIT WHEN v_cursor%NOTFOUND;

        -- Process the retrieved values as needed
        DBMS_OUTPUT.PUT_LINE('Car ID: ' || v_car_id);
        DBMS_OUTPUT.PUT_LINE('Car Brand: ' || v_car_brand);
        DBMS_OUTPUT.PUT_LINE('Car Model: ' || v_car_model);
           DBMS_OUTPUT.PUT_LINE('Car Adress: ' ||   v_adress);
             DBMS_OUTPUT.PUT_LINE('----------');
    END LOOP;

    CLOSE v_cursor;
END;



CREATE OR REPLACE FUNCTION GET_SEARCH_USER_BY_NAME (
    p_user_name VARCHAR2
) RETURN SYS_REFCURSOR AS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        SELECT user_id, user_name, user_email, user_img, user_password, user_date_of_birth, user_role, phone, user_passport, credit_card
        FROM users
        WHERE user_name LIKE '%' || p_user_name || '%';

    RETURN v_result;
END;

DECLARE
    v_cursor SYS_REFCURSOR;
    v_user_id NUMBER(10);
    v_user_name VARCHAR2(50);
    v_user_email VARCHAR2(50);
    v_user_img BLOB;
    v_user_password VARCHAR2(128);
    v_user_date_of_birth DATE;
    v_user_role NUMBER(10);
    v_phone VARCHAR2(20);
    v_user_passport VARCHAR2(20);
    v_credit_card VARCHAR2(20);
BEGIN
    v_cursor := GET_SEARCH_USER_BY_NAME(p_user_name => 'Pavel');

    LOOP
        FETCH v_cursor INTO v_user_id, v_user_name, v_user_email, v_user_img, v_user_password,
                           v_user_date_of_birth, v_user_role, v_phone, v_user_passport, v_credit_card;
        EXIT WHEN v_cursor%NOTFOUND;

        -- Process the retrieved values as needed
        DBMS_OUTPUT.PUT_LINE('User ID: ' || v_user_id);
        DBMS_OUTPUT.PUT_LINE('User Name: ' || v_user_name);
        DBMS_OUTPUT.PUT_LINE('User Email: ' || v_user_email);
        -- Output other retrieved columns
    END LOOP;

    CLOSE v_cursor;
END;










CREATE OR REPLACE FUNCTION SEARCHCARBYNAME(
    car_model_name IN VARCHAR2
) RETURN SYS_REFCURSOR IS
    car_results SYS_REFCURSOR;
BEGIN
    OPEN car_results FOR
    SELECT *
    FROM CARS
    WHERE car_model = car_model_name;

    RETURN car_results;
END;





DECLARE
    car_cursor SYS_REFCURSOR;
    car_record CARS%ROWTYPE;
BEGIN
    car_cursor := SEARCHCARBYNAME('Largus');

    LOOP
        FETCH car_cursor INTO car_record;
        EXIT WHEN car_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Brand: ' || car_record.car_brand);
        DBMS_OUTPUT.PUT_LINE('License Plate: ' || car_record.license_plate);
    END LOOP;

    CLOSE car_cursor;
END;