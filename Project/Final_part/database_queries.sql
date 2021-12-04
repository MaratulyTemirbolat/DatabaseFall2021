CREATE VIEW all_customers AS
SELECT id, full_name, phone_number, account_number_id
FROM offline_customers
UNION
SELECT id, full_name, phone_number, account_number_id
FROM online_customers
ORDER BY id;


CREATE VIEW all_orders AS
SELECT id,
       tracking_number,
       purchase_date,
       payment_type,
       arrived_warehouse_id,
       total_price,
       arrival_date,
       customer_id
FROM offline_orders
UNION
SELECT id,
       tracking_number,
       purchase_date,
       payment_type,
       arrived_warehouse_id,
       total_price,
       arrival_date,
       customer_id
FROM online_orders;

-- Extra functions
CREATE OR REPLACE FUNCTION get_order_id(online_offline_terminal bool)
    RETURNS INT
AS
$$
DECLARE
    final_id        INT;
    number_elements INT;
BEGIN

    IF (online_offline_terminal = true)
    THEN
        number_elements := (SELECT COUNT(*) FROM offline_orders);
        IF (number_elements = 0)
        THEN
            final_id := 1;
        ELSE
            final_id := (SELECT id + 2 FROM offline_orders ORDER BY id DESC LIMIT 1);
        END IF;
    ELSE
        number_elements := (SELECT COUNT(*) FROM online_orders);
        IF (number_elements = 0)
        THEN
            final_id := 2;
        ELSE
            final_id := (SELECT id + 2 FROM online_orders ORDER BY id DESC LIMIT 1);
        END IF;
    END IF;

    RETURN final_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_customer_id(online_offline_terminal bool)
    RETURNS INT
AS
$$
DECLARE
    final_id        INT;
    number_elements INT;
BEGIN

    IF (online_offline_terminal = true)
    THEN
        number_elements := (SELECT COUNT(*) FROM offline_customers);
        IF (number_elements = 0)
        THEN
            final_id := 1;
        ELSE
            final_id := (SELECT id + 2 FROM offline_customers ORDER BY id DESC LIMIT 1);
        END IF;
    ELSE
        number_elements := (SELECT COUNT(*) FROM online_customers);
        IF (number_elements = 0)
        THEN
            final_id := 2;
        ELSE
            final_id := (SELECT id + 2 FROM online_customers ORDER BY id DESC LIMIT 1);
        END IF;
    END IF;
    RETURN final_id;
END;
$$ LANGUAGE plpgsql;

SELECT get_customer_id(true), get_customer_id(false);
SELECT get_order_id(true), get_order_id(false);


-- Queries

-- Assume the package shipped by USPS with tracking number 123456 is reported to have been
-- destroyed in an accident. Find the contact information for the customer. Also, find the contents
-- of that shipment and create a new shipment of replacement items.
CREATE OR REPLACE PROCEDURE create_destroyed_shipment(order_id INT)
AS
$$
DECLARE
    customer_id_           INT          := (SELECT customer_id
                                            FROM all_orders
                                            WHERE id = order_id
                                            LIMIT 1);
    even_terminal CONSTANT INT          := 2;
    new_id_order           INT;
    new_tracking_number    INT;
    customer_full_name     varchar(100) := (SELECT full_name
                                            FROM all_customers
                                            WHERE id = customer_id_);
    customer_phone_number  varchar(15)  := (SELECT phone_number
                                            FROM all_customers
                                            WHERE id = customer_id_);
BEGIN
    IF (order_id % even_terminal = 0) -- online
    THEN
        new_id_order := get_order_id(false);

        INSERT INTO order_tracking(departure_city_id, current_city_id, arrival_city_id, last_date_update, description,
                                   order_status_id)
        SELECT departure_city_id, departure_city_id, arrival_city_id, CURRENT_DATE, 'Accepted to be processed', 1
        FROM order_tracking
        WHERE tracking_number = (SELECT tracking_number FROM online_orders WHERE id = order_id LIMIT 1);

        new_tracking_number := (SELECT tracking_number FROM order_tracking ORDER BY tracking_number DESC LIMIT 1);

        INSERT INTO online_orders(id, tracking_number, purchase_date, payment_type, arrived_warehouse_id, total_price,
                                  season_id, arrival_date, shipper_id, customer_id, shipper_price, weight,
                                  account_bill_id)
        SELECT new_id_order,
               new_tracking_number,
               CURRENT_DATE,
               payment_type,
               arrived_warehouse_id,
               total_price,
               season_id,
               (CURRENT_DATE + (arrival_date - purchase_date)),
               shipper_id,
               customer_id,
               shipper_price,
               weight,
               account_bill_id
        FROM online_orders
        WHERE id = order_id;

        INSERT INTO online_order_products(online_order_id, product_id, quantity)
        SELECT new_id_order, product_id, quantity
        FROM online_order_products
        WHERE online_order_id = order_id;

        INSERT INTO shipper_tracking(shipper_id, tracking_number)
        SELECT shipper_id, new_tracking_number
        FROM online_orders
        WHERE id = order_id;

    ELSE -- offline
        new_id_order := get_order_id(true);

        INSERT INTO order_tracking(departure_city_id, current_city_id, arrival_city_id, last_date_update, description,
                                   order_status_id)
        SELECT departure_city_id, departure_city_id, arrival_city_id, CURRENT_DATE, 'Accepted to be processed', 1
        FROM order_tracking
        WHERE tracking_number = (SELECT tracking_number FROM offline_orders WHERE id = order_id LIMIT 1);

        new_tracking_number := (SELECT tracking_number FROM order_tracking ORDER BY tracking_number DESC LIMIT 1);

        INSERT INTO offline_orders(id, tracking_number, purchase_date, payment_type, customer_id, arrived_warehouse_id,
                                   total_price, arrival_date, employee_id, season_id, weight, account_bill_id)
        SELECT new_id_order,
               new_tracking_number,
               CURRENT_DATE,
               payment_type,
               customer_id,
               arrived_warehouse_id,
               total_price,
               (CURRENT_DATE + (arrival_date - purchase_date)),
               employee_id,
               season_id,
               weight,
               account_bill_id
        FROM offline_orders
        WHERE id = order_id;

        INSERT INTO offline_order_products(offline_order_id, product_id, quantity)
        SELECT new_id_order, product_id, quantity
        FROM offline_order_products
        WHERE offline_order_id = order_id;
    END IF;

    RAISE NOTICE 'The products for the customer: % with id: % were successfully reorganized. Sorry for the inconvenience. Customer contact: %',customer_full_name,customer_id_,customer_phone_number;
END;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION update_function_trigger()
    RETURNS TRIGGER
AS
$$
DECLARE
    tracking_number_old    INT := (SELECT OLD.tracking_number);
    tracking_number_new    INT := (SELECT NEW.tracking_number);
    current_tracking_state INT := (SELECT NEW.order_status_id);
    order_id               INT := (SELECT id
                                   FROM all_orders
                                   WHERE tracking_number = tracking_number_new
                                   LIMIT 1);
BEGIN
    IF (tracking_number_new = tracking_number_old)
    THEN
        IF (current_tracking_state = 7)
        THEN
            call create_destroyed_shipment(order_id);
        END IF;
    END IF;

    RETURN NEW;
END;
$$ language plpgsql;

CREATE TRIGGER update_order_tracking_trigger
    AFTER UPDATE
    ON order_tracking
    FOR EACH ROW
EXECUTE PROCEDURE update_function_trigger();

-- TEST CHECKING FOR DEYSTROYMENT
UPDATE order_tracking
SET order_status_id = 7,
    description     = 'Груз был сломан при выгрузке'
WHERE tracking_number = 2;

SELECT *
FROM order_tracking o_t
         JOIN order_status o_s
              ON o_t.order_status_id = o_s.id
         JOIN all_orders a_o
              ON a_o.tracking_number = o_t.tracking_number
ORDER BY o_t.tracking_number;

-- Find the customer who has bought the most (by price) in the past year

SELECT a_c.id AS customer_id, a_c.full_name AS full_name, SUM(total_price) AS total_purchase_price
FROM all_orders a_o
         JOIN all_customers a_c
              ON a_o.customer_id = a_c.id
WHERE EXTRACT(YEAR FROM purchase_date) = 2021
GROUP BY a_c.id, a_c.full_name
ORDER BY total_purchase_price DESC
LIMIT 1;

-- Find the top 2 products by dollar-amount sold in the past year.
CREATE VIEW all_order_products AS
SELECT online_order_id AS order_id, product_id, quantity
FROM online_order_products
UNION
SELECT offline_order_id AS order_id, product_id, quantity
FROM offline_order_products;

SELECT prod.id AS product_id, prod.name AS product_name, SUM(product_price) AS product_total_price
FROM all_orders a_o
         JOIN all_order_products a_o_p
              ON a_o.id = a_o_p.order_id
         JOIN warehouses w
              ON w.id = a_o.arrived_warehouse_id
         JOIN store_inventory s_i
              ON s_i.store_id = w.attached_store_id AND s_i.product_id = a_o_p.product_id
         JOIN products prod
              ON prod.id = s_i.product_id
WHERE EXTRACT(YEAR FROM purchase_date) = 2021
GROUP BY prod.id, prod.name
ORDER BY product_total_price DESC
LIMIT 2;

-- Find the top 2 products by unit sales in the past year

SELECT prod.id AS product_id, prod.name AS product_name, SUM(quantity) AS sold_product_quantity
FROM all_orders a_o
         JOIN all_order_products a_o_p
              ON a_o.id = a_o_p.order_id
         JOIN warehouses w
              ON w.id = a_o.arrived_warehouse_id
         JOIN store_inventory s_i
              ON s_i.store_id = w.attached_store_id AND s_i.product_id = a_o_p.product_id
         JOIN products prod
              ON prod.id = s_i.product_id
WHERE EXTRACT(YEAR FROM purchase_date) = 2021
GROUP BY prod.id, prod.name
ORDER BY sold_product_quantity DESC
LIMIT 2;

--  Find those products that are out-of-stock at every store in California.
SELECT pr.id, pr.name, SUM(s_i.remainded_quantity) AS remained_product_number
FROM stores
         JOIN streets
              ON stores.street_id = streets.id
         JOIN cities c
              ON streets.city_id = c.id
         JOIN regions r
              ON r.id = c.region_id
         JOIN store_inventory s_i
              ON s_i.store_id = stores.id
         JOIN products pr
              ON pr.id = s_i.product_id
WHERE r.name = 'California'
GROUP BY pr.id, pr.name
HAVING SUM(s_i.remainded_quantity) = 0
ORDER BY remained_product_number;

-- Another possible query
SELECT stores.name AS store_name,pr.name AS product_name,remainded_quantity,r.name AS region_name
FROM stores
         JOIN streets
              ON stores.street_id = streets.id
         JOIN cities c
              ON streets.city_id = c.id
         JOIN regions r
              ON r.id = c.region_id
         JOIN store_inventory s_i
              ON s_i.store_id = stores.id
         JOIN products pr
              ON pr.id = s_i.product_id
WHERE r.name = 'California' AND remainded_quantity = 0;

--  Find those packages that were not delivered within the promised time.
SELECT a_o.id            AS order_id,
       o_t.tracking_number,
       a_o.total_price   AS package_total_price,
       a_o.purchase_date AS package_purchase_date,
       a_o.arrival_date  AS package_arrival_date,
       o_t.description   AS package_tracking_description,
       o_s.name          AS package_tracking_status
FROM all_orders a_o
         JOIN order_tracking o_t
              ON o_t.tracking_number = a_o.tracking_number
         JOIN order_status o_s
              ON o_s.id = o_t.order_status_id
WHERE o_s.name NOT IN ('Arrived', 'Issued')
  AND arrival_date <= CURRENT_DATE;

-- Generate the bill for each customer for the past month.

SELECT a_c.full_name                                                           AS customer_full_name,
       pr.name                                                                 AS product_name,
       CONCAT(quantity, ' * ', product_price, ' = ', product_price * quantity) AS price_description,
       purchase_date,
       payment_type
FROM all_customers a_c
         JOIN all_orders a_o
              ON a_c.id = a_o.customer_id
         JOIN all_order_products a_o_p
              ON a_o_p.order_id = a_o.id
         JOIN products pr
              ON pr.id = a_o_p.product_id
         JOIN warehouses w
              ON w.id = a_o.arrived_warehouse_id
         JOIN stores s
              ON s.id = w.attached_store_id
         JOIN store_inventory s_i
              ON s_i.store_id = s.id AND s_i.product_id = a_o_p.product_id
WHERE EXTRACT(MONTH FROM purchase_date) = 12;


