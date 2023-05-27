CREATE OR REPLACE PROCEDURE EXPORT_USERS_TO_XML_FILE(FILE_PATH IN VARCHAR2) IS
  XML_DATA XMLTYPE;
  XML_FILE UTL_FILE.FILE_TYPE;
BEGIN
  SELECT XMLELEMENT("USERS", XMLAGG(XMLELEMENT("USER", 
    XMLFOREST(user_id, user_name, user_email, user_password, user_date_of_birth,phone, user_passport, credit_card ))))
  INTO XML_DATA
  FROM USERS;

  XML_FILE := UTL_FILE.FOPEN('IMPORT_EXPORT', FILE_PATH, 'W', 32767);

  UTL_FILE.PUT_LINE(XML_FILE, '<?xml version="1.0" encoding="UTF-8"?>');
  UTL_FILE.PUT_LINE(XML_FILE, XML_DATA.GETCLOBVAL());

  UTL_FILE.FCLOSE(XML_FILE);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('������ ������������� �� �������.');
  WHEN UTL_FILE.INVALID_PATH THEN
    DBMS_OUTPUT.PUT_LINE('�������� ���� � �����.');
  WHEN UTL_FILE.WRITE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('������ ������ � ����.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('��������� ������: ' || SQLERRM);
END;

CREATE DIRECTORY IMPORT_EXPORT AS 'D:\OracleBD\oradata\CARSH';
CALL EXPORT_USERS_TO_XML_FILE('Ckients.xml');




CREATE OR REPLACE FUNCTION IMPORT_USERS_FROM_XML_FILE(FILE_PATH IN VARCHAR2)
  RETURN SYS_REFCURSOR AS
  XML_DATA XMLTYPE;
  USER_NAME VARCHAR2(255);
  USER_EMAIL VARCHAR2(255);
  USER_PASSWORD VARCHAR2(255);
  USER_DATE_OF_BIRTH DATE;
  USER_PASSPORT VARCHAR2(255);
  CREDIT_CARD VARCHAR2(255);
  CURSOR USER_CURSOR IS
    SELECT *
    FROM XMLTABLE('/USERS/USER'
                  PASSING XML_DATA
                  COLUMNS USER_NAME VARCHAR2(255) PATH 'USER_NAME',
                          USER_EMAIL VARCHAR2(255) PATH 'USER_EMAIL',
                          USER_PASSWORD VARCHAR2(255) PATH 'USER_PASSWORD',
                          USER_DATE_OF_BIRTH DATE PATH 'USER_DATE_OF_BIRTH',
                          USER_PASSPORT VARCHAR2(255) PATH 'USER_PASSPORT',
                          CREDIT_CARD VARCHAR2(255) PATH 'CREDIT_CARD');

  RESULT SYS_REFCURSOR;
BEGIN
  DELETE FROM TEMP_USERS;

  SELECT XMLTYPE(BFILENAME('IMPORT_EXPORT', FILE_PATH), NLS_CHARSET_ID('UTF8'))
  INTO XML_DATA
  FROM DUAL;

  OPEN USER_CURSOR;
  LOOP
    FETCH USER_CURSOR INTO USER_NAME, USER_EMAIL, USER_PASSWORD, USER_DATE_OF_BIRTH, USER_PASSPORT, CREDIT_CARD;
    EXIT WHEN USER_CURSOR%NOTFOUND;
    INSERT INTO TEMP_USERS (USER_NAME, USER_EMAIL, USER_PASSWORD, USER_DATE_OF_BIRTH, USER_PASSPORT, CREDIT_CARD)
    VALUES (USER_NAME, USER_EMAIL, USER_PASSWORD, USER_DATE_OF_BIRTH, USER_PASSPORT, CREDIT_CARD);
  END LOOP;
  CLOSE USER_CURSOR;

  OPEN RESULT FOR
    SELECT USER_NAME, USER_EMAIL, USER_PASSWORD, USER_DATE_OF_BIRTH, USER_PASSPORT, CREDIT_CARD
    FROM TEMP_USERS;

  RETURN RESULT;
END;

DECLARE
  RESULT_CURSOR SYS_REFCURSOR;
  USER_NAME VARCHAR2(255);
  USER_EMAIL VARCHAR2(255);
  USER_PASSWORD VARCHAR2(255);
  USER_DATE_OF_BIRTH DATE;
  USER_PASSPORT VARCHAR2(255);
  CREDIT_CARD VARCHAR2(255);
BEGIN
  RESULT_CURSOR := IMPORT_USERS_FROM_XML_FILE('USERS.xml');
  LOOP
    FETCH RESULT_CURSOR INTO USER_NAME, USER_EMAIL, USER_PASSWORD, USER_DATE_OF_BIRTH, USER_PASSPORT, CREDIT_CARD;
    EXIT WHEN RESULT_CURSOR%NOTFOUND;
  END LOOP;
  CLOSE RESULT_CURSOR;
END;


CREATE GLOBAL TEMPORARY TABLE TEMP_USERS
(
        USER_NAME VARCHAR2(255) ,
         USER_EMAIL VARCHAR2(255),
          USER_PASSWORD VARCHAR2(255),
         USER_DATE_OF_BIRTH DATE,
          USER_PASSPORT VARCHAR2(255),
          CREDIT_CARD VARCHAR2(255)
)
ON COMMIT PRESERVE ROWS;

DELETE FROM TEMP_USERS;
SELECT * FROM TEMP_USERS;