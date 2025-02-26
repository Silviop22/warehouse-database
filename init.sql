CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE users
(
    id                  BIGINT PRIMARY KEY           DEFAULT nextval('user_seq'),
    email               VARCHAR(255) UNIQUE NOT NULL,
    first_name          VARCHAR(100)        NOT NULL,
    last_name           VARCHAR(100)        NOT NULL,
    password            TEXT                NOT NULL,
    role                VARCHAR(50)         NOT NULL,
    expired             BOOLEAN             NOT NULL DEFAULT FALSE,
    locked              BOOLEAN             NOT NULL DEFAULT FALSE,
    credentials_expired BOOLEAN             NOT NULL DEFAULT FALSE,
    enabled             BOOLEAN             NOT NULL DEFAULT TRUE
);

CREATE SEQUENCE item_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE items
(
    id             BIGINT PRIMARY KEY DEFAULT nextval('item_seq'),
    name           VARCHAR(255)     NOT NULL,
    quantity       DOUBLE PRECISION NOT NULL,
    unit_price     DOUBLE PRECISION NOT NULL,
    package_volume DOUBLE PRECISION NOT NULL
);

CREATE TABLE trucks
(
    chassis_number   VARCHAR(255) PRIMARY KEY,
    licence_plate    VARCHAR(255),
    container_volume DOUBLE PRECISION NOT NULL,
    tier             VARCHAR(50)      NOT NULL,
    CONSTRAINT unique_truck UNIQUE (chassis_number, container_volume)
);

CREATE SEQUENCE order_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE orders
(
    order_number   BIGINT PRIMARY KEY DEFAULT nextval('order_seq'),
    submitted_date DATE,
    status         VARCHAR(50) NOT NULL,
    deadline       DATE,
    customer_id    BIGINT,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES users (id) ON DELETE SET NULL
);


CREATE SEQUENCE order_truck_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE order_truck
(
    id             BIGINT PRIMARY KEY DEFAULT nextval('order_truck_seq'),
    chassis_number VARCHAR(255) NOT NULL,
    order_number   BIGINT       NOT NULL,
    CONSTRAINT fk_order_truck_truck FOREIGN KEY (chassis_number) REFERENCES trucks (chassis_number) ON DELETE CASCADE,
    CONSTRAINT fk_order_truck_order FOREIGN KEY (order_number) REFERENCES orders (order_number) ON DELETE CASCADE
);


