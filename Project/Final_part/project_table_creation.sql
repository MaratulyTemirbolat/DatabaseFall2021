CREATE TABLE positions(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE types(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE regions(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE cities(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region_id INTEGER,
    CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES regions(id)
);

CREATE TABLE streets(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city_id INTEGER NOT NULL,
    CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE manufactures(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE,
    street_id INTEGER NOT NULL,
    house_number varchar(10),
    flat_number varchar(10),
    CONSTRAINT fk_street_id FOREIGN KEY (street_id) REFERENCES streets(id)
);

CREATE TABLE order_status(
    id SERIAL PRIMARY KEY,
    name varchar(50) UNIQUE NOT NULL
);

CREATE TABLE order_tracking(
    tracking_number SERIAL PRIMARY KEY,
    departure_city_id INTEGER,
    current_city_id INTEGER,
    arrival_city_id INTEGER,
    last_date_update date NOT NULL,
    description text,
    order_status_id INTEGER,
    CONSTRAINT fk_departure_city_id FOREIGN KEY (departure_city_id) REFERENCES cities(id),
    CONSTRAINT fk_current_city_id FOREIGN KEY (current_city_id) REFERENCES cities(id),
    CONSTRAINT fk_arrival_city_id FOREIGN KEY (arrival_city_id) REFERENCES cities(id),
    CONSTRAINT fk_order_status_id FOREIGN KEY (order_status_id) REFERENCES order_status(id)
);

CREATE TABLE shippers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    street_id INTEGER,
    house_number VARCHAR(10),
    flat_number VARCHAR(10),
    price_per_kilogram INT CHECK ( price_per_kilogram > 0 ),
    CONSTRAINT fk_street_id FOREIGN KEY (street_id) REFERENCES streets(id)
);

CREATE TABLE shipper_tracking(
    shipper_id INT,
    tracking_number INT,
    CONSTRAINT fk_shipper_id FOREIGN KEY (shipper_id) REFERENCES shippers(id),
    CONSTRAINT fk_tracking_number FOREIGN KEY (tracking_number) REFERENCES order_tracking(tracking_number),
    CONSTRAINT pk_shipper_tracking PRIMARY KEY (shipper_id,tracking_number)
);

CREATE TABLE stores(
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) UNIQUE NOT NULL,
    street_id INT,
    house_number VARCHAR(10),
    flat_number VARCHAR(10),
    CONSTRAINT fk_street_id FOREIGN KEY (street_id) REFERENCES streets(id)
);

CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    street_id INT,
    house_number VARCHAR(10) NOT NULL,
    flat_number VARCHAR(10) NOT NULL,
    date_of_birth DATE NOT NULL,
    working_position_id INT,
    store_id INT,
    CONSTRAINT fk_street_id FOREIGN KEY (street_id) REFERENCES streets(id),
    CONSTRAINT fk_working_position FOREIGN KEY (working_position_id) REFERENCES positions(id),
    CONSTRAINT fk_store_id FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE phones(
    id SERIAL PRIMARY KEY ,
    owner_id INT,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES employees(id)
);

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    category_id INT,
    type_id INT,
    manufacturer_id INT,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES categories(id),
    CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES types(id),
    CONSTRAINT fk_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES manufactures(id)
);

CREATE TABLE warehouses(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    attached_store_id INT,
    street_id INT,
    house_number VARCHAR(10) NOT NULL,
    flat_number VARCHAR(10),
    CONSTRAINT fk_store_id FOREIGN KEY (attached_store_id) REFERENCES stores(id),
    CONSTRAINT fk_street_id FOREIGN KEY (street_id) REFERENCES streets(id)
);

CREATE TABLE seasons(
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE
);

CREATE TABLE warehouse_manufacturer_audit(
    id SERIAL PRIMARY KEY,
    warehouse_id INT,
    manufacturer_id INT,
    product_id INT,
    description TEXT NOT NULL,
    required_quantity INTEGER CHECK ( required_quantity > 0 ),
    CONSTRAINT fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES warehouses(id),
    CONSTRAINT fk_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES manufactures(id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE store_warehouse_audit(
    id SERIAL PRIMARY KEY,
    store_id INT,
    warehouse_id INT,
    product_id INT,
    description TEXT NOT NULL,
    required_quantity INT CHECK(required_quantity > 0),
    CONSTRAINT fk_store_id FOREIGN KEY (store_id) REFERENCES stores(id),
    CONSTRAINT fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES warehouses(id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE warehouse_inventory(
    warehouse_id INT,
    product_id INT,
    remained_quantity INT CHECK ( remained_quantity > 0 ),
    last_date_revision DATE NOT NULL CHECK ( last_date_revision <= CURRENT_DATE ),
    last_date_product_update DATE NOT NULL CHECK ( last_date_product_update <= CURRENT_DATE ),
    minimum_quantity INT CHECK ( minimum_quantity > 0 ),
    CONSTRAINT fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES warehouses(id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE account_numbers(
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(150)
);

CREATE TABLE offline_customers(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    account_number_id INT,
    CONSTRAINT fk_account_number_id FOREIGN KEY (account_number_id) REFERENCES account_numbers(id)
);

CREATE TABLE online_customers(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    account_id INT,
    date_of_birth DATE CHECK (date_of_birth <= CURRENT_DATE),
    account_number_id INT,
    CONSTRAINT fk_account_number_id FOREIGN KEY (account_number_id) REFERENCES account_numbers(id)
);

CREATE TABLE cards(
    id SERIAL PRIMARY KEY,
    card_number VARCHAR(20) UNIQUE,
    bank_name VARCHAR(20) NOT NULL,
    card_type VARCHAR(20) NOT NULL,
    expiration_date DATE NOT NULL,
    cvv_code INT NOT NULL,
    owner_id INT,
    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES online_customers(id)
);

CREATE TABLE account_bill(
    id SERIAL PRIMARY KEY,
    account_number_id INT,
    monthly_payment INT CHECK ( monthly_payment >= 0 ) NOT NULL ,
    month_number INT CHECK ( month_number >= 0 ) NOT NULL,
    CONSTRAINT fk_account_number_id FOREIGN KEY (account_number_id) REFERENCES account_numbers(id)
);

CREATE TABLE offline_orders(
    id INT PRIMARY KEY,
    tracking_number INT NOT NULL,
    purchase_date DATE CHECK ( purchase_date <= CURRENT_DATE),
    payment_type VARCHAR(10) NOT NULL,
    customer_id INT,
    arrived_warehouse_id INT,
    total_price INT CHECK ( total_price > 0 ),
    arrival_date DATE CHECK ( arrival_date >= purchase_date),
    employee_id INT,
    season_id INT,
    weight FLOAT CHECK ( weight > 0.0 ),
    account_bill_id INT,
    CONSTRAINT fk_tracking_number FOREIGN KEY (tracking_number) REFERENCES order_tracking(tracking_number),
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES offline_customers(id),
    CONSTRAINT fk_arrived_warehouse_id FOREIGN KEY (arrived_warehouse_id) REFERENCES warehouses(id),
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees(id),
    CONSTRAINT fk_season_id FOREIGN KEY (season_id) REFERENCES seasons(id),
    CONSTRAINT fk_account_bill_id FOREIGN KEY (account_bill_id) REFERENCES account_bill(id)
);

CREATE TABLE online_orders(
    id INT PRIMARY KEY,
    tracking_number INT,
    purchase_date DATE CHECK ( purchase_date <= CURRENT_DATE),
    payment_type VARCHAR(20) NOT NULL,
    arrived_warehouse_id INT,
    total_price INT CHECK ( total_price > 0 ),
    season_id INT ,
    arrival_date DATE CHECK ( arrival_date >= purchase_date),
    shipper_id INT,
    customer_id INT,
    shipper_price INT CHECK(shipper_price >= 0),
    weight FLOAT CHECK ( weight > 0.0 ),
    account_bill_id INT,
    CONSTRAINT fk_tracking_number FOREIGN KEY (tracking_number) REFERENCES order_tracking(tracking_number),
    CONSTRAINT fk_arrived_warehouse_id FOREIGN KEY (arrived_warehouse_id) REFERENCES warehouses(id),
    CONSTRAINT fk_season_id FOREIGN KEY (season_id) REFERENCES seasons(id),
    CONSTRAINT fk_shipper_id FOREIGN KEY (shipper_id) REFERENCES shippers(id),
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES online_customers(id),
    CONSTRAINT fk_account_bill_id FOREIGN KEY (account_bill_id) REFERENCES account_bill(id)
);

CREATE TABLE store_inventory(
    store_id INT,
    product_id INT,
    remainded_quantity INT CHECK ( remainded_quantity >= 0),
    last_date_revision DATE CHECK ( last_date_revision <= CURRENT_DATE ),
    last_date_product_update DATE CHECK (last_date_product_update <= CURRENT_DATE),
    minimum_product_quantity INT CHECK ( minimum_product_quantity >= 0 ),
    CONSTRAINT fk_store_id FOREIGN KEY (store_id) REFERENCES stores(id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT pk_store_inventory PRIMARY KEY (store_id,product_id)
);

ALTER TABLE store_inventory
ADD COLUMN product_price INT CHECK(product_price >= 0);

CREATE TABLE online_order_products(
    online_order_id INT,
    product_id INT,
    quantity INT CHECK ( quantity > 0 ),
    CONSTRAINT fk_online_order_id FOREIGN KEY (online_order_id) REFERENCES online_orders(id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT pk_online_order_products PRIMARY KEY (online_order_id,product_id)
);

CREATE TABLE offline_order_products(
    offline_order_id INT,
    product_id INT,
    quantity INT CHECK ( quantity > 0 ),
    CONSTRAINT fk_offline_order_id FOREIGN KEY (offline_order_id) REFERENCES offline_orders(id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT pk_offline_order_products PRIMARY KEY (offline_order_id,product_id)
);

