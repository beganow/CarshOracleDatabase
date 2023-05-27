CREATE OR REPLACE PROCEDURE CALL_ENCRYPT_PASSWORD(
PASSWORD IN VARCHAR2,
ENCRYPTED_PASSWORD OUT VARCHAR2
)
IS
BEGIN
ENCRYPTED_PASSWORD := ENCRYPT_PASSWORD(PASSWORD);
END;


DECLARE
  encrypted_password VARCHAR2(32767);
BEGIN
  CALL_ENCRYPT_PASSWORD('Admin', encrypted_password);
  DBMS_OUTPUT.PUT_LINE('Encrypted password: ' || encrypted_password);
END;





CREATE OR REPLACE PROCEDURE CALL_DECRYPT_PASSWORD(
  CIPHER_TEXT IN VARCHAR2,
  DECRYPTED_PASSWORD OUT VARCHAR2
)
IS
BEGIN
  DECRYPTED_PASSWORD := DECRYPT_PASSWORD(CIPHER_TEXT);
END;


DECLARE
  decrypted_password VARCHAR2(32767);
BEGIN
  CALL_DECRYPT_PASSWORD('7388C5CDDABF6F2CB265F7D69E5290B7', decrypted_password);
  DBMS_OUTPUT.PUT_LINE('Decrypted password: ' || decrypted_password);
END;




CREATE OR REPLACE PROCEDURE CALL_REGISTER(
    IN_USER_ID IN NUMBER,
    IN_USER_NAME IN VARCHAR2,
    IN_USER_EMAIL IN VARCHAR2,
    IN_USER_IMG IN VARCHAR2,
    IN_USER_PASSWORD IN VARCHAR2,
    IN_USER_DATE_OF_BIRTH IN DATE,
    IN_USER_ROLE_ID IN NUMBER,
    IN_USER_PHONE IN VARCHAR2,
    IN_USER_PASSPORT IN VARCHAR2,
    IN_USER_CREDIT_CARD IN VARCHAR2,
    OUT_USER_ID OUT NUMBER
)
IS
BEGIN
    OUT_USER_ID := REGISTER(
        IN_USER_ID,
        IN_USER_NAME,
        IN_USER_EMAIL,
        IN_USER_IMG,
        IN_USER_PASSWORD,
        IN_USER_DATE_OF_BIRTH,
        IN_USER_ROLE_ID,
        IN_USER_PHONE,
        IN_USER_PASSPORT,
        IN_USER_CREDIT_CARD
    );
    DBMS_OUTPUT.PUT_LINE('User registered successfully. User ID: ' || OUT_USER_ID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error registering user: ' || SQLERRM);
        RAISE;
END;


DECLARE
    USER_ID NUMBER;
BEGIN
    CALL_REGISTER(
        IN_USER_ID => 11,
        IN_USER_NAME => 'Maksim',
        IN_USER_EMAIL => 'Darilewfila23456@gmail.com',
        IN_USER_IMG => '10.jpg',
        IN_USER_PASSWORD => 'Dari765Dar',
        IN_USER_DATE_OF_BIRTH => '12-12-99',
        IN_USER_ROLE_ID => 1,
        IN_USER_PHONE => '123432890',
        IN_USER_PASSPORT => 'AB123456',
        IN_USER_CREDIT_CARD => '1234567890123456',
        OUT_USER_ID => USER_ID
    );
    -- Do something with the returned user ID
    DBMS_OUTPUT.PUT_LINE('Registered User ID: ' || USER_ID);
END;




CREATE OR REPLACE PROCEDURE CALL_LOGIN(
    IN_USER_EMAIL IN VARCHAR2,
    IN_USER_PASSWORD IN VARCHAR2,
    OUT_LOGIN_STATUS OUT NUMBER
)
IS
BEGIN
    OUT_LOGIN_STATUS := LOGIN(IN_USER_EMAIL, IN_USER_PASSWORD);
    IF OUT_LOGIN_STATUS = 1 THEN
        DBMS_OUTPUT.PUT_LINE('User login successful.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error logging in user.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error logging in user: ' || SQLERRM);
        RAISE;
END;

DECLARE
    LOGIN_STATUS NUMBER;
BEGIN
    CALL_LOGIN(
        IN_USER_EMAIL => 'Pashok12.obodov@gmail.com',
        IN_USER_PASSWORD => 'Admin1232',
        OUT_LOGIN_STATUS => LOGIN_STATUS
    );
    DBMS_OUTPUT.PUT_LINE('Login Status: ' || LOGIN_STATUS);
END;



CREATE OR REPLACE PROCEDURE CALL_TOTAL_PRICE(
    IN_PRICING_ID IN NUMBER,
    IN_CAR_ID IN NUMBER,
    IN_PRICE_PER_MIN IN NUMBER,
    IN_COUNT_MIN IN NUMBER,
    OUT_PRICING_ID OUT NUMBER
)
IS
BEGIN
    OUT_PRICING_ID := TOTAL_PRICE(
        IN_PRICING_ID,
        IN_CAR_ID,
        IN_PRICE_PER_MIN,
        IN_COUNT_MIN
    );
    DBMS_OUTPUT.PUT_LINE('Inserted into table and calculated total_price successfully. Pricing ID: ' || OUT_PRICING_ID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting into table: ' || SQLERRM);
        RAISE;
END;

DECLARE
    PRICING_ID NUMBER;
BEGIN
    CALL_TOTAL_PRICE(
        IN_PRICING_ID => 1,
        IN_CAR_ID => 123,
        IN_PRICE_PER_MIN => 10,
        IN_COUNT_MIN => 30,
        OUT_PRICING_ID => PRICING_ID
    );
    DBMS_OUTPUT.PUT_LINE('Inserted Pricing ID: ' || PRICING_ID);
END;





CREATE OR REPLACE PROCEDURE CALL_ADD_CAR(
    IN_CAR_ID IN NUMBER,
    IN_CAR_BRAND IN VARCHAR2,
    IN_CAR_MODEL IN VARCHAR2,
    IN_BODY_ID IN NUMBER,
    IN_CAR_INFO IN VARCHAR2,
    IN_TYPE_FUEL IN VARCHAR2,
    IN_LICENSE_PLATE IN VARCHAR2,
    IN_COLOR IN VARCHAR2,
    IN_CAR_IMG IN VARCHAR2,
    IN_CAR_CONDITION IN NUMBER,
    OUT_CAR_ID OUT NUMBER
)
IS
BEGIN
    OUT_CAR_ID := ADD_CAR(
        IN_CAR_ID,
        IN_CAR_BRAND,
        IN_CAR_MODEL,
        IN_BODY_ID,
        IN_CAR_INFO,
        IN_TYPE_FUEL,
        IN_LICENSE_PLATE,
        IN_COLOR,
        IN_CAR_IMG,
        IN_CAR_CONDITION
    );
    DBMS_OUTPUT.PUT_LINE('Car added successfully. Car ID: ' || OUT_CAR_ID);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding car: ' || SQLERRM);
        RAISE;
END;


DECLARE
    CAR_ID NUMBER;
BEGIN
    DEV.CALL_ADD_CAR(
        IN_CAR_ID => 16,
        IN_CAR_BRAND => 'Toyota',
        IN_CAR_MODEL => 'Camry',
        IN_BODY_ID => 2,
        IN_CAR_INFO => 'Lorem ipsum dolor sit amet',
        IN_TYPE_FUEL => 'Petrol',
        IN_LICENSE_PLATE => 'ABC14623',
        IN_COLOR => 'Red',
        IN_CAR_IMG => 'car2.jpg',
        IN_CAR_CONDITION => 2,
        OUT_CAR_ID => CAR_ID
    );
    DBMS_OUTPUT.PUT_LINE('Added Car ID: ' || CAR_ID);
END;




create or replace PROCEDURE INSERT_ROLE(
    p_role_id IN NUMBER,
    p_role_name IN VARCHAR2
)
AS
BEGIN
    INSERT INTO ROLE(role_id, role_name)
    VALUES (p_role_id, p_role_name);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error inserting data: ' || SQLERRM);
END;

CALL INSERT_ROLE(1, 'admin');




create or replace PROCEDURE INSERT_BOOKING(
    in_booking_id IN NUMBER,
    in_user_id IN NUMBER,
    in_car_id IN NUMBER,
    in_start_time IN DATE, 
    in_end_time IN DATE
)
AS
    v_count_user_bookings NUMBER;
    v_count_car_bookings NUMBER;
BEGIN
    -- Проверка, что пользователь не забронировал другую машину в тот же день
    SELECT COUNT(*) INTO v_count_user_bookings
    FROM BOOKING
    WHERE user_id = in_user_id
      AND TRUNC(start_time) = TRUNC(in_start_time);

    IF v_count_user_bookings > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'User already has a booking on the same day.');
    END IF;
    -- Проверка, что машина не забронирована другим пользователем в то же время
    SELECT COUNT(*) INTO v_count_car_bookings
    FROM BOOKING
    WHERE car_id = in_car_id
      AND (   (in_start_time >= start_time AND in_start_time < end_time)
           OR (in_end_time > start_time AND in_end_time <= end_time)
           OR (in_start_time <= start_time AND in_end_time >= end_time));

    IF v_count_car_bookings > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Car is already booked during the specified time.');
    END IF;

    -- Вставка записи бронирования
    INSERT INTO BOOKING(booking_id, user_id, car_id, start_time, end_time)
    VALUES (in_booking_id, in_user_id, in_car_id, in_start_time, in_end_time);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error inserting data: ' || SQLERRM);
END;


CALL DEV.INSERT_BOOKING(7, 10, 5, TO_DATE('2023-10-05', 'YYYY-MM-DD'), TO_DATE('2023-10-07', 'YYYY-MM-DD'));
 
 
 



create or replace PROCEDURE INSERT_CONDITION(
    p_condition_id IN NUMBER,
    p_percent_condition IN NUMBER,
    p_recommends IN VARCHAR2
)
AS
BEGIN
    INSERT INTO CONDITION(condition_id, percent_condition, recomends)
    VALUES (p_condition_id, p_percent_condition,  
        CASE
            WHEN p_percent_condition BETWEEN 0 AND 20 THEN 'Repair needed now'
            WHEN p_percent_condition BETWEEN 21 AND 50 THEN 'Repair needed urgently'
            WHEN p_percent_condition BETWEEN 51 AND 70 THEN 'Repair needed soon'
            WHEN p_percent_condition BETWEEN 71 AND 100 THEN 'No repair needed'
            ELSE 'Invalid condition percentage'
        END
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error inserting data: ' || SQLERRM);
END;

CALL INSERT_CONDITION(1, 75, '');



create or replace PROCEDURE INSERT_BODY_DEFAUL(
    p_body_id IN NUMBER,
    p_body_name IN VARCHAR2
)
AS
    l_count NUMBER;
BEGIN
    -- Проверяем наличие существующей записи с заданным body_id
    SELECT COUNT(*) INTO l_count
    FROM BODY
    WHERE body_id = p_body_id;

    IF l_count > 0 THEN
        -- Если запись уже существует, генерируем ошибку
        RAISE_APPLICATION_ERROR(-20001, 'Record with body_id ' || p_body_id || ' already exists.');
    ELSE
        -- Вставляем новую запись
        INSERT INTO BODY(body_id, body_name)
        VALUES (p_body_id, p_body_name);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error inserting data: ' || SQLERRM);
END;


CALL INSERT_BODY_DEFAUL(1, 'Sedan');




CREATE OR REPLACE PROCEDURE INSERT_PAYMENTS(
    in_payment_id IN NUMBER,
    in_user_id IN NUMBER,
    in_payment_date IN DATE
)
AS
    v_start_time DATE;
    v_end_time DATE;
    v_calculated_amount NUMBER(10, 2);
BEGIN
    SELECT start_time, end_time
    INTO v_start_time, v_end_time
    FROM BOOKING
    WHERE BOOKING.user_id = in_user_id;
        SELECT COUNT(*) INTO v_calculated_amount
        FROM BOOKING
        WHERE user_id = in_user_id;
    IF v_calculated_amount > 0 AND in_payment_date > v_start_time AND in_payment_date < v_end_time THEN
        INSERT INTO PAYMENTS(payment_id, user_id, amount, payment_date)
        VALUES (in_payment_id, in_user_id, v_calculated_amount, in_payment_date);

        COMMIT;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Invalid amount or payment date.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;


CALL INSERT_PAYMENTS(2, 4, TO_DATE('2023-08-11', 'YYYY-MM-DD'));



create or replace PROCEDURE INSERT_BODY AS
    I PLS_INTEGER := 5;
BEGIN
    -- Вставляем новые записи
    WHILE I <= 100000 LOOP
        INSERT INTO BODY (body_id, body_name) VALUES (I, 'BODY ' || I);
        I := I + 1;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error inserting data: ' || SQLERRM);
END;

CALL INSERT_BODY;



create or replace PROCEDURE DELETE_USER(IN_USER_ID NUMBER)
AS 
BEGIN
    DELETE FROM BOOKING WHERE USER_ID = IN_USER_ID;
     DELETE FROM PAYMENTS WHERE USER_ID = IN_USER_ID;
      DELETE FROM USERS WHERE USER_ID = IN_USER_ID;
       COMMIT;
    DBMS_OUTPUT.PUT_LINE('USER deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleted user: ' || SQLERRM);
END;

create or replace PROCEDURE DELETE_PAYMENT(IN_PAYMENT_ID NUMBER)
AS 
    BEGIN
        DELETE FROM PAYMENTS WHERE payment_id = IN_PAYMENT_ID;

 COMMIT;
    DBMS_OUTPUT.PUT_LINE('Payment deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleted payment: ' || SQLERRM);
END;

CAll DELETE_PAYMENT(2);



create or replace PROCEDURE DELETE_BOOKING(IN_BOOKING_ID NUMBER)
AS 
    BEGIN
        DELETE FROM BOOKING WHERE booking_id = IN_BOOKING_ID;

 COMMIT;
    DBMS_OUTPUT.PUT_LINE('Booking deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleted booking: ' || SQLERRM);
END;

CALL DEV.DELETE_BOOKING(7);




create or replace PROCEDURE DELETE_CAR(IN_CAR_ID NUMBER)
AS 
    BEGIN
        DELETE FROM BOOKING WHERE CAR_ID = IN_CAR_ID;   
        DELETE FROM PRICING WHERE CAR_ID = IN_CAR_ID;
         DELETE FROM CARS WHERE CAR_ID = IN_CAR_ID;

 COMMIT;
    DBMS_OUTPUT.PUT_LINE('CAR deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleted car: ' || SQLERRM);
END;

CALL DELETE_CAR(1);


create or replace PROCEDURE update_booking(
    p_booking_id IN NUMBER,
    p_start_time IN DATE,
    p_end_time IN DATE
)
IS
BEGIN
    UPDATE BOOKING
    SET start_time = p_start_time,
        end_time = p_end_time
    WHERE booking_id = p_booking_id;
         DBMS_OUTPUT.PUT_LINE('Booking update success.');
    COMMIT; -- Optional, if you want to commit the changes immediately
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Booking not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK; -- Optional, if you want to rollback the changes in case of an error
END;

call update_booking(1, TO_DATE('2023-10-05', 'YYYY-MM-DD'), TO_DATE('2023-10-07', 'YYYY-MM-DD'));



create or replace PROCEDURE UPDATE_CAR(
    in_car_id IN NUMBER,
    in_car_brand IN VARCHAR2,
    in_car_model IN VARCHAR2,
    in_body_id IN NUMBER,
    in_car_info IN VARCHAR2,
    in_type_fuel IN VARCHAR2,
    in_license_plate IN VARCHAR2,
    in_color IN VARCHAR2,
    in_car_img IN VARCHAR2,
    in_car_condition IN NUMBER,
    in_car_adress VARCHAR2
)
AS
    car_img BLOB;
    car_bfile BFILE := BFILENAME('MY_IMAGE_DIR', in_car_img);
BEGIN
    DBMS_LOB.OPEN(car_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.CREATETEMPORARY(car_img, TRUE);
    DBMS_LOB.LOADFROMFILE(car_img, car_bfile, DBMS_LOB.GETLENGTH(car_bfile));
    DBMS_LOB.CLOSE(car_bfile);

    UPDATE CARS
    SET
        CAR_BRAND = in_car_brand,
        CAR_MODEL = in_car_model,
        BODY_ID = in_body_id,
        CAR_INFO = TO_CLOB(in_car_info),
        TYPE_FUEL = in_type_fuel,
        LICENSE_PLATE = in_license_plate,
        COLOR = in_color,
        CAR_IMAGE = car_img,
        CAR_CONDITION = in_car_condition,
        Adress = in_car_adress
    WHERE
        CAR_ID = in_car_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Car updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating car: ' || SQLERRM);
END;

CALL UPDATE_CAR(1, 'INFINITI', 'FX-35', 1, 'Отличный вариант', 'бензин', 'ER234-5', 'белый', 'car2.jpg', 3);


create or replace PROCEDURE UPDATE_PRICING(
    in_pricing_id IN NUMBER,
    in_price_per_min IN NUMBER,
    in_count_min IN NUMBER
)
AS  total NUMBER;
    BEGIN  
    total :=in_price_per_min * in_count_min;
    UPDATE PRICING SET
    price_per_min = in_price_per_min,
    count_min = in_count_min,
    total_price = total
    Where pricing_id = in_pricing_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Pricing updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating car: ' || SQLERRM);
END;

CALL UPDATE_PRICING(1, 3, 30);


create or replace PROCEDURE UPDATE_USER(
    in_user_id IN NUMBER,
    in_user_name IN VARCHAR2,
    in_user_email IN VARCHAR2, 
    in_user_img IN VARCHAR2,
    in_user_date_of_birth IN DATE,
    in_user_phone IN VARCHAR2,
    in_user_passport IN VARCHAR2,
    in_user_credit_card IN VARCHAR2
)
AS
    l_blob BLOB;
    l_bfile BFILE;
BEGIN
    IF in_user_img is not null then
    l_bfile:= BFILENAME('MY_IMAGE_DIR', in_user_img);
    DBMS_LOB.OPEN(l_bfile, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.CREATETEMPORARY(l_blob, TRUE);
    DBMS_LOB.LOADFROMFILE(l_blob, l_bfile, DBMS_LOB.GETLENGTH(l_bfile));
    DBMS_LOB.CLOSE(l_bfile);

    UPDATE USERS
    SET USER_NAME = in_user_name,
        USER_EMAIL = in_user_email,
        USER_IMG = l_blob,
        USER_DATE_OF_BIRTH = in_user_date_of_birth,
        PHONE = in_user_phone,
        USER_PASSPORT = in_user_passport,
        CREDIT_CARD = in_user_credit_card
    WHERE USER_ID = in_user_id;
    else 
    UPDATE USERS
    SET USER_NAME = in_user_name,
        USER_EMAIL = in_user_email,
         USER_IMG = null,
        USER_DATE_OF_BIRTH = in_user_date_of_birth,
        PHONE = in_user_phone,
        USER_PASSPORT = in_user_passport,
        CREDIT_CARD = in_user_credit_card
    WHERE USER_ID = in_user_id;
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('User updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating user: ' || SQLERRM);
END;


CALL UPDATE_USER(1, 'Admin' , 'fhewhfew@gmail.com', '2.jpg', '20-09-99', '+375446532789', 'KB32552316', '4255-1903-5678-4587');



create or replace PROCEDURE UPDATE_USER_PASSWORD(
    IN_USER_ID NUMBER,
    IN_USER_PASSWORD VARCHAR2
)
AS
    ENCRYPTED_PASSWORD VARCHAR2(32767) := ENCRYPT_PASSWORD(IN_USER_PASSWORD);
BEGIN
    UPDATE USERS
    SET USER_PASSWORD = ENCRYPTED_PASSWORD
    WHERE USER_ID = IN_USER_ID;
     COMMIT;
    DBMS_OUTPUT.PUT_LINE('User password updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating user password: ' || SQLERRM);
END;


CALL UPDATE_USER_PASSWORD(2, 'efwhfewhhef');




CREATE OR REPLACE PROCEDURE CALL_COUNT_ROWS(
    TABLE_NAME IN VARCHAR2,
    OUT_ROW_COUNT OUT NUMBER
)
IS
BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || TABLE_NAME INTO OUT_ROW_COUNT;
    DBMS_OUTPUT.PUT_LINE('Row count: ' || OUT_ROW_COUNT);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error counting rows: ' || SQLERRM);
        RAISE;
END;



DECLARE
    ROW_COUNT NUMBER;
BEGIN
    CALL_COUNT_ROWS(
        TABLE_NAME => 'Cars',
        OUT_ROW_COUNT => ROW_COUNT
    );
END;


DECLARE
    ROW_COUNT NUMBER;
BEGIN
    CALL_COUNT_ROWS(
        TABLE_NAME => 'Booking',
        OUT_ROW_COUNT => ROW_COUNT
    );
END;

DECLARE
    ROW_COUNT NUMBER;
BEGIN
    CALL_COUNT_ROWS(
        TABLE_NAME => 'Users',
        OUT_ROW_COUNT => ROW_COUNT
    );
END;
