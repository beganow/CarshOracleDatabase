CREATE OR REPLACE VIEW ALL_INFO_USER AS
SELECT USERS.USER_ID, USER_NAME, USER_EMAIL, USER_IMG,
 USER_PASSWORD, USER_DATE_OF_BIRTH, PHONE, USER_PASSPORT, CREDIT_CARD, ROLE.ROLE_NAME
FROM USERS
JOIN ROLE ON USERS.USER_ROLE = ROLE.ROLE_ID;

SELECT * FROM DEV.ALL_INFO_USER;

DROP VIEW ALL_INFO_USER;


CREATE OR REPLACE VIEW ALL_INFO_CAR AS
SELECT C.car_id, C.car_brand, C.car_model, C.car_info, C.type_fuel, C.license_plate, C.Adress,
C.color , C.car_image, B.body_name, CO.percent_condition, CO.recomends
FROM CARS C
JOIN BODY B ON C.body_id = B. body_id
JOIN CONDITION CO ON C.car_condition=CO.condition_id;

SELECT * FROM ALL_INFO_CAR;

DROP VIEW ALL_INFO_CAR;

CREATE OR REPLACE VIEW PRICING_CAR AS
SELECT  C.car_brand, C.car_model, C.car_image, C.car_info, C.license_plate, 
C.color,P.price_per_min, P.count_min, P.total_price
FROM PRICING P
JOIN CARS C ON P.car_id = C.car_id;

SELECT * FROM PRICING_CAR;

DROP VIEW PRICING_CAR;

CREATE OR REPLACE VIEW ALL_PAYMENTS AS
SELECT U.user_name, U.user_img, U.credit_card, U.user_email, P.amount, P.payment_date
FROM PAYMENTS P
JOIN USERS U ON P.user_id = U.user_id;

SELECT * FROM ALL_PAYMENTS;
DROP VIEW  ALL_PAYMENTS;


CREATE OR REPLACE VIEW ALL_BOOKING AS
SELECT U.user_name, U.user_img, U.credit_card, U.user_email,C.car_brand, C.car_model, C.car_info, C.car_image, B.start_time, B.end_time
FROM BOOKING B
JOIN USERS U ON B.user_id = U.user_id
JOIN CARS C ON B.car_id=C.car_id;

SELECT * FROM ALL_BOOKING;

DROP VIEW  ALL_BOOKING;




/*CREATE OR REPLACE PROCEDURE Call_View_Procedure AS
  view_data SYS_REFCURSOR;
  view_result VARCHAR2(100);

BEGIN
  -- Открываем курсор для получения данных из представления
  OPEN view_data FOR SELECT column_name FROM your_view_name;

  -- Читаем данные из курсора и выводим результат
  LOOP
    FETCH view_data INTO view_result;
    EXIT WHEN view_data%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Result: '  view_result);
  END LOOP;

  -- Закрываем курсор
  CLOSE view_data;

EXCEPTION
  WHEN OTHERS THEN
    -- Обработка ошибок
    DBMS_OUTPUT.PUT_LINE('An error occurred: '  SQLERRM);
END;*/
