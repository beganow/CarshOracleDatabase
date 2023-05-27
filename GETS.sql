CREATE OR REPLACE FUNCTION GETUSERS
RETURN SYS_REFCURSOR
AS
    user_cursor SYS_REFCURSOR;
BEGIN
    OPEN user_cursor FOR
        SELECT U.USER_ID, U.USER_NAME, U.USER_IMG, U.USER_EMAIL, U.USER_PASSWORD,
               U.USER_DATE_OF_BIRTH, R.ROLE_NAME
        FROM USERS U
        JOIN ROLE R ON U.USER_ROLE = R.ROLE_ID
        ORDER BY U.USER_ID;
    
    RETURN user_cursor;
END;

VAR user_result REFCURSOR
EXECUTE :user_result := DEV.GETUSERS;

PRINT user_result;


CREATE OR REPLACE FUNCTION GETUSERBYID(USERID NUMBER)
RETURN SYS_REFCURSOR
AS
    user_cursor SYS_REFCURSOR;
BEGIN
    OPEN user_cursor FOR
        SELECT U.USER_ID, U.USER_NAME, U.USER_IMG, U.USER_EMAIL, U.USER_PASSWORD,
               U.USER_DATE_OF_BIRTH, R.ROLE_NAME
        FROM USERS U
        JOIN ROLE R ON U.USER_ROLE = R.ROLE_ID
        WHERE U.USER_ID = USERID;
    
    RETURN user_cursor;
END;

VAR user_result REFCURSOR;
EXECUTE :user_result := DEV.GETUSERBYID(2);

PRINT user_result;


CREATE OR REPLACE FUNCTION GETCARS
RETURN SYS_REFCURSOR
AS
    car_cursor SYS_REFCURSOR;
BEGIN
    OPEN car_cursor FOR
        SELECT C.CAR_ID, C.CAR_BRAND, C.CAR_MODEL, C.BODY_ID, C.CAR_INFO, C.Adress,
               C.TYPE_FUEL, C.LICENSE_PLATE, C.COLOR, C.CAR_IMAGE, C.CAR_CONDITION
        FROM CARS C;
    
    RETURN car_cursor;
END;

VAR car_result REFCURSOR;
EXECUTE :car_result := GETCARS;

PRINT car_result;



CREATE OR REPLACE FUNCTION GETCARBYID(CARID NUMBER)
RETURN SYS_REFCURSOR
AS
    car_cursor SYS_REFCURSOR;
BEGIN
    OPEN car_cursor FOR
        SELECT C.CAR_ID, C.CAR_BRAND, C.CAR_MODEL, C.BODY_ID, C.CAR_INFO,  C.Adress,
               C.TYPE_FUEL, C.LICENSE_PLATE, C.COLOR, C.CAR_IMAGE, C.CAR_CONDITION
        FROM CARS C
        WHERE C.CAR_ID = CARID;
    
    RETURN car_cursor;
END;

VAR car_result REFCURSOR;
EXECUTE :car_result := GETCARBYID(1);

PRINT car_result;


CREATE OR REPLACE FUNCTION GETCARNAMEBYPRICINGID(PRICEID NUMBER)
RETURN VARCHAR2
AS
    car_name VARCHAR2(50);
BEGIN
    SELECT C.CAR_BRAND || ' ' || C.CAR_MODEL
    INTO car_name
    FROM CARS C
    JOIN PRICING P ON C.CAR_ID = P.CAR_ID
    WHERE P.PRICING_ID = PRICEID;
    
    RETURN car_name;
END;

DECLARE
    car_name VARCHAR2(50);
BEGIN
    car_name := GETCARNAMEBYPRICINGID(1);
    DBMS_OUTPUT.PUT_LINE('Car Name: ' || car_name);
END;


CREATE OR REPLACE FUNCTION GETTOTALPRICEBYCARID(CARID NUMBER)
RETURN NUMBER
AS
    total_price NUMBER(10,2);
BEGIN
    SELECT SUM(P.TOTAL_PRICE)
    INTO total_price
    FROM PRICING P
    WHERE P.CAR_ID = CARID;
    
    RETURN total_price;
END;

DECLARE
    car_id NUMBER(10);
    total_price NUMBER(10,2);
BEGIN
    car_id := 1;
    total_price := GETTOTALPRICEBYCARID(car_id);
    DBMS_OUTPUT.PUT_LINE('Total Price for Car ID ' || car_id || ': ' || total_price);
END;


CREATE OR REPLACE FUNCTION GETCONDITIONBYLICENSEPLATE(LICENSEPLATE VARCHAR2)
RETURN VARCHAR2
AS
    car_condition VARCHAR2(50);
BEGIN
    SELECT C.RECOMENDS
    INTO car_condition
    FROM CARS A
    JOIN PRICING P ON A.CAR_ID = P.CAR_ID
    JOIN CONDITION C ON A.CAR_CONDITION = C.CONDITION_ID
    WHERE A.LICENSE_PLATE = LICENSEPLATE;
    
    RETURN car_condition;
END;

DECLARE
    CONDITION VARCHAR2(50);
BEGIN
    CONDITION := GETCONDITIONBYLICENSEPLATE('ER234-5'); -- Replace 'ABC123' with the desired license plate
    DBMS_OUTPUT.PUT_LINE('Car Condition: ' || CONDITION);
END;


CREATE OR REPLACE FUNCTION GETUSERNAMEBYPAYMENT_DATE(PAYMENTDATE DATE)
RETURN VARCHAR2
AS
    user_name VARCHAR2(50);
BEGIN
    SELECT U.USER_NAME
    INTO user_name
    FROM USERS U
    JOIN PAYMENTS P ON U.USER_ID = P.USER_ID
    WHERE P.PAYMENT_DATE = PAYMENTDATE;
    
    RETURN user_name;
END;

DECLARE
    payment_date DATE;
    user_name VARCHAR2(32767);
BEGIN
    payment_date := TO_DATE('2023-08-11', 'YYYY-MM-DD');
    user_name := GETUSERNAMEBYPAYMENT_DATE(payment_date);
    DBMS_OUTPUT.PUT_LINE('User Name for Payment Date ' || TO_CHAR(payment_date, 'YYYY-MM-DD') || ': ' || user_name);
END;


CREATE OR REPLACE FUNCTION GETBOOKINGBYUSERID(USERID NUMBER)
RETURN SYS_REFCURSOR
AS
    cur SYS_REFCURSOR;
BEGIN
    OPEN cur FOR
        SELECT B.BOOKING_ID, B.START_TIME, B.END_TIME, C.CAR_BRAND, C.CAR_MODEL
        FROM BOOKING B
        JOIN CARS C ON B.CAR_ID = C.CAR_ID
        WHERE B.USER_ID = USERID;
    
    RETURN cur;
END;

DECLARE
    user_id NUMBER(10);
    booking_cur SYS_REFCURSOR;
    booking_id NUMBER(10);
    start_time DATE;
    end_time DATE;
    car_brand VARCHAR2(20);
    car_model VARCHAR2(30);
BEGIN
    user_id := 2;
    booking_cur := GETBOOKINGBYUSERID(user_id);
    
    LOOP
        FETCH booking_cur INTO booking_id, start_time, end_time, car_brand, car_model;
        EXIT WHEN booking_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Booking ID: ' || booking_id || ', Start Time: ' || start_time || ', End Time: ' || end_time || ', Car: ' || car_brand || ' ' || car_model);
    END LOOP;
    
    CLOSE booking_cur;
END;



CREATE OR REPLACE FUNCTION GET_ROLE
    RETURN SYS_REFCURSOR
IS
    CUR SYS_REFCURSOR;
BEGIN
    OPEN CUR FOR
        SELECT role_id, role_name FROM ROLE;
    RETURN CUR;
END;


DECLARE
    ROLE_CURSOR SYS_REFCURSOR;
    ROLE_ID NUMBER;
    ROLE_NAME VARCHAR2(50);
BEGIN
    ROLE_CURSOR := GET_ROLE;
    LOOP
        FETCH ROLE_CURSOR INTO ROLE_ID, ROLE_NAME;
        EXIT WHEN ROLE_CURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Role ID: ' || ROLE_ID || ', Role Name: ' || ROLE_NAME);
    END LOOP;
    CLOSE ROLE_CURSOR;
END;



CREATE OR REPLACE FUNCTION GET_BODY
RETURN SYS_REFCURSOR
AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT *
    FROM BODY;
    
    RETURN v_cursor;
END;



DECLARE
    v_cursor SYS_REFCURSOR;
    v_body_id NUMBER(10);
    v_body_name VARCHAR2(20);
BEGIN
    v_cursor := GET_BODY; -- Вызов функции и присвоение курсора переменной
    
    LOOP
        FETCH v_cursor INTO v_body_id, v_body_name; -- Извлечение данных из курсора
        
        EXIT WHEN v_cursor%NOTFOUND; -- Выход из цикла, когда достигнут конец курсора
        
        -- Обработка данных
        DBMS_OUTPUT.PUT_LINE('Body ID: ' || v_body_id);
        DBMS_OUTPUT.PUT_LINE('Body Name: ' || v_body_name);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
    
    CLOSE v_cursor; -- Закрытие курсора
END;




CREATE OR REPLACE FUNCTION GET_CONDITION
RETURN SYS_REFCURSOR
AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT *
    FROM CONDITION;
    
    RETURN v_cursor;
END;

DECLARE
    v_cursor SYS_REFCURSOR;
    v_condition_id NUMBER(10);
    v_percent_condition NUMBER(5, 2);
    v_recommends VARCHAR2(50);
BEGIN
    v_cursor := GET_CONDITION; -- Вызов функции и присвоение курсора переменной
    
    LOOP
        FETCH v_cursor INTO v_condition_id, v_percent_condition, v_recommends; -- Извлечение данных из курсора
        
        EXIT WHEN v_cursor%NOTFOUND; -- Выход из цикла, когда достигнут конец курсора
        
        -- Обработка данных
        DBMS_OUTPUT.PUT_LINE('Condition ID: ' || v_condition_id);
        DBMS_OUTPUT.PUT_LINE('Percent Condition: ' || v_percent_condition);
        DBMS_OUTPUT.PUT_LINE('Recommends: ' || v_recommends);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
    END LOOP;
    
    CLOSE v_cursor; -- Закрытие курсора
END;