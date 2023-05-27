------------------------TABLESPACE--------------------------------
CREATE TABLESPACE TS_USER
DATAFILE 'D:\OracleBD\oradata\CARSH\TS_USER.dbf'
SIZE 100M
AUTOEXTEND ON;

CREATE TABLESPACE TS_CARS
DATAFILE 'D:\OracleBD\oradata\CARSH\TS_CARS.dbf'
SIZE 100M
AUTOEXTEND ON;

CREATE TABLESPACE TS_BOOKING
DATAFILE 'D:\OracleBD\oradata\CARSH\TS_BOOKING.dbf'
SIZE 100M
AUTOEXTEND ON;

CREATE TABLESPACE TS_PAYMENTS
DATAFILE 'D:\OracleBD\oradata\CARSH\TS_PAYMENTS.dbf'
SIZE 100M
AUTOEXTEND ON;

-----------------------------------CREATE TABLES----------------------------
---------------------TABLE USERS -------------------------------------------
CREATE TABLE USERS (
   user_id NUMBER(10) PRIMARY KEY,
   user_name VARCHAR2(50) NOT NULL,
   user_email VARCHAR2(50) NOT NULL UNIQUE,
   user_img BlOB,
   user_password VARCHAR2(128) NOT NULL,
   user_date_of_birth DATE,
   user_role NUMBER(10),
   phone VARCHAR2(20) NOT NULL UNIQUE,
   user_passport VARCHAR2(20) NOT NULL UNIQUE,
   credit_card VARCHAR2(20) NOT NULL UNIQUE,
   CONSTRAINT FK_USER_ROLE FOREIGN KEY (USER_ROLE) REFERENCES ROLE (ROLE_ID)
)TABLESPACE TS_USER;
 
---------------------TABLE ROLE -------------------------------------------
CREATE TABLE ROLE(
    role_id NUMBER(10) PRIMARY KEY,
    role_name VARCHAR2(50) NOT NULL
)TABLESPACE TS_USER;

---------------------TABLE BOOKING -------------------------------------------
CREATE TABLE BOOKING(
    booking_id NUMBER(10) PRIMARY KEY,
    user_id NUMBER(10),
    car_id NUMBER(10) UNIQUE ,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    CONSTRAINT FK_BOOKING_USER FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
    CONSTRAINT FK_BOOKING_CARS FOREIGN KEY (CAR_ID) REFERENCES CARS(CAR_ID),
    CONSTRAINT CK_BOOKING_TIME CHECK (end_time > start_time)
)TABLESPACE TS_BOOKING;

---------------------TABLE PAYMENTS -------------------------------------------
CREATE TABLE PAYMENTS(
    payment_id NUMBER(10) PRIMARY KEY,
    user_id NUMBER(10),
    amount NUMBER(10, 2) NOT NULL,
    payment_date DATE,
    CONSTRAINT FK_PAYMENTS_USER FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
)TABLESPACE TS_PAYMENTS;

---------------------TABLE CARS -------------------------------------------
CREATE TABLE CARS(
    car_id NUMBER(10) PRIMARY KEY,
    car_brand VARCHAR2(20) NOT NULL,
    car_model VARCHAR2(30) NOT NULL,
    body_id NUMBER(10) NOT NULL,
    car_info CLOB NOT NULL,
    type_fuel VARCHAR2(20) NOT NULL,
    license_plate VARCHAR2(20) NOT NULL UNIQUE,
    color VARCHAR2(20) NOT NULL,
    car_image BLOB NOT NULL,
    car_condition NUMBER(10) NOT NULL,
    Adress VARCHAR2(50),
    CONSTRAINT FK_CARS_BODY FOREIGN KEY (BODY_ID) REFERENCES BODY (BODY_ID),
    CONSTRAINT FK_CARS_CONDITION FOREIGN KEY (CAR_CONDITION) REFERENCES CONDITION(CONDITION_ID)
)TABLESPACE TS_CARS;

---------------------TABLE BODY -------------------------------------------
CREATE TABLE BODY(
    body_id NUMBER(10) PRIMARY KEY,
    body_name VARCHAR2(20) NOT NULL
)TABLESPACE TS_CARS;

---------------------TABLE CONDITION -------------------------------------------
CREATE TABLE CONDITION(
    condition_id NUMBER(10) PRIMARY KEY,
    percent_condition NUMBER(5,2) NOT NULL CHECK ((percent_condition>=0) and (percent_condition<=100)),
    recomends VARCHAR2(50) NOT NULL
)TABLESPACE TS_CARS;

DELETE FROM CONDITION WHERE CONDITION_ID=4;

---------------------TABLE PRICING -------------------------------------------
CREATE TABLE PRICING(
    pricing_id NUMBER(10) PRIMARY KEY,
    car_id NUMBER(10) NOT NULL,
    price_per_min NUMBER(10,2) NOT NULL,
    count_min NUMBER(10) NOT NULL,
    total_price NUMBER(10) NOT NULL,
     CONSTRAINT FK_PRICING_CARS FOREIGN KEY(CAR_ID) REFERENCES CARS(CAR_ID)
)TABLESPACE TS_CARS;



SELECT owner, table_name FROM all_tables WHERE table_name='ROLE';

SELECT owner
FROM all_views
WHERE view_name = 'ALL_INFO_USER';
