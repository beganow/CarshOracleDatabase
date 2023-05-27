CREATE INDEX IDX_USER_EMAIL ON USERS(USER_EMAIL);
CREATE INDEX IDX_USER_NAME ON USERS(USER_NAME);
CREATE INDEX IDX_MODEL ON CARS(CAR_MODEL);
CREATE INDEX IDX_USER_ID ON USERS(USER_ID);
CREATE INDEX IDX_CONDITION_ID ON CONDITION(condition_id);
CREATE INDEX IDX_PAYMENT_USER_ID ON PAYMENTS(USER_ID);
CREATE INDEX IDX_PRICING_CAR_ID ON PRICING(CAR_ID);
CREATE INDEX IDX_BOOKING_USER_ID ON BOOKING(USER_ID);
CREATE INDEX IDX_BOOKING_CAR_ID ON BOOKING(CAR_ID);