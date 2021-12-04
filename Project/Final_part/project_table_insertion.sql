INSERT INTO positions(name)
VALUES ('manager'),
       ('administrator'),
       ('main manager'),
       ('shop assistant');

INSERT INTO categories(name)
VALUES ('Appliances'),              -- Бытовая техника 1
       ('Smartphones and gadgets'), -- 2
       ('Computers'),               -- 3
       ('TV/Audio/Video'); -- 4

INSERT INTO types(name)
VALUES ('Mobile phones'),    -- 1
       ('Watches'),          -- 2
       ('Electronic books'), -- 3
       ('System heatings'),  -- 4
       ('Charging devices'), -- 5
       ('Protected cases'),  -- 6
       ('Cables'),           -- 7
       ('Freezers'),         -- Морозильники 8
       ('Fridges'),          -- Холодильники 9
       ('Washers'),          -- Стиральные машинки 10
       ('Vacuum cleaners'),  -- 11
       ('Irons'),            -- 12
       ('Laptops'),          -- 13
       ('Laptop bags'); -- 14

INSERT INTO regions(name)
VALUES ('California'), --1
       ('Texas'),      -- 2
       ('Arizona'),    -- 3
       ('New Mexico'), --4
       ('Nevada'),     --5
       ('Oregon'),     --6
       ('Colorado');-- 7

INSERT INTO cities(name, region_id)
VALUES ('Los Angeles', 1),  --1
       ('San Diego', 1),    -- 2
       ('San Jose', 1),     --3
       ('San Francisco', 1),-- 4
       ('Fresno', 1),       --5
       ('Houston', 2),      --6
       ('San Antonio', 2),  --7
       ('Dallas', 2),       -- 8
       ('Austin', 2),       -- 9
       ('Phoenix', 3),      -- 10
       ('Tucson', 3),       -- 11
       ('Alamogordo', 4),   -- 12
       ('Albuquerque', 4),  -- 13
       ('Las Vegas', 5),    -- 14
       ('Henderson', 5),    -- 15
       ('Portland', 6),     -- 16
       ('Denver', 7),       -- 17
       ('Aurora', 7); -- 18

INSERT INTO streets(name, city_id)
VALUES ('Rodeo Drive', 1),
       ('Hollywood Boulevard', 1),
       ('Sunset Boulevard', 1),
       ('Mulholland Drive', 1),
       ('Melrose Avenue', 1),
       ('5th Avenue', 2),
       ('El Prado', 2),
       ('University Avenue', 2),
       ('Bailey Ave', 3),
       ('Leland Ave', 3),
       ('Los Coches Ave', 3),
       ('Macarthur Ave', 3),
       ('Lombard', 4),
       ('Haight', 4),
       ('Castro', 4),
       ('Valencia', 4),
       ('Buford', 6),
       ('Sauer', 6),
       ('Stillwell', 6),
       ('Barnes', 6),
       ('Houston', 7),
       ('Broadway', 7),
       ('South Alamo', 7),
       ('Sixth', 9),
       ('Rainey', 9),
       ('Seaholm', 9),
       ('Stone Avenue', 11),
       ('Sixth Avenue', 11),
       ('Fourth Avenue', 11),
       ('Acoma Ave', 12),
       ('Adams Ave', 12),
       ('Adobe Ave', 12),
       ('Lead Ave', 13),
       ('Roma Ave', 13),
       ('Boulevard', 14),
       ('Fremont', 14),
       ('163rd PI SE', 15),
       ('Abbeyfield Rose Drive', 15),
       ('82nd Avenue', 16),
       ('Alberta', 16),
       ('Beaverton-Hillsdale Highway', 16),
       ('10th St', 17),
       ('11900 E', 17),
       ('14th St', 17);

INSERT INTO manufactures(id, name, email, street_id, house_number, flat_number)
VALUES (27, 'Apple', 'apple@gmail.com', 1, '53A', '121'),
       (28, 'Samsung', 'samsung@gmail.com', 1, '123F/2', '200'),
       (29, 'Honor', 'honor@gmail.com', 1, '20A/F', ''),
       (30, 'Xiaomi', 'xiaomi@gmail.com', 2, '28', '63'),
       (31, 'HP', 'hp@gmail.com', 2, '39A', '54'),
       (32, 'HTC', 'htc@gmail.com', 3, '23B', ''),
       (33, 'LG', 'lifegood@gmail.com', 4, '12A', ''),
       (34, 'Sony', 'sony@gmail.com', 5, '40B', '12'),
       (35, 'Hon Hai', 'honhai@gmail.com', 5, '49C', ''),
       (36, 'Dell', 'dell@gmail.com', 6, '13C', ''),
       (37, 'Hitachi', 'hitachi@gmail.com', 6, '200A', '40A'),
       (38, 'Panasonic', 'panasonic@gmail.com', 7, '13AB', 'O5S'),
       (39, 'Intel', 'intel@gmail.com', 8, '13A', 'PL3'),
       (40, 'Haier', 'haier@gmail.com', 9, '101B', ''),
       (41, 'Lenovo', 'lenovo@gmail.com', 9, '120', ''),
       (42, 'Prestigio', 'prestigio@gmail.com', 10, '100', ''),
       (43, 'BQ Mobile', 'bqmobile@gmail.com', 10, '23q', ''),
       (44, 'Fly', 'fly@gmail.com', 11, '33C', 'AAA'),
       (45, 'Gionee', 'gionee@gmail.com', 12, '32B/2', 'A2'),
       (46, 'Huawei', 'huawei@gmail.com', 12, '23A', ''),
       (47, 'Intex', 'intex@gmail.com', 13, 'A91', 'BB1'),
       (48, 'Meizu', 'meizu@gmail.com', 14, 'B20', 'B20'),
       (49, 'Philips', 'philips@gmail.com', 14, 'C300', ''),
       (50, 'Micromax', 'micromax@gmail.com', 15, 'D200', ''),
       (51, 'Bravis', 'bravis@gmail.com', 16, 'O102', '102'),
       (52, 'Defender', 'defender@gmail.com', 18, '742', ''),
       (53, 'Elenberg', 'elenberg@gmail.com', 19, '239', ''),
       (54, 'A-case', 'acase@gmail.com', 20, 'BA23', '');

INSERT INTO order_status(name)
VALUES ('Accepted'),
       ('Sent'),
       ('On Way'),
       ('Arrived'), --
       ('Lost'),    -- Потерян
       ('Issued'); -- Выдан
INSERT INTO order_status(name)
VALUES ('Destroyed'),
       ('Processed');


INSERT INTO shippers(name, street_id, house_number, flat_number, price_per_kilogram)
VALUES ('Glovo', 2, '28A', '632', 20),
       ('FAB', 1, '200B', '333', 15),
       ('QJB', 3, '230Q', 'QB23', 10),
       ('FAST Pro', 4, '321', '923', 14),
       ('Continent Logistics', 5, '22F1', '', 18),
       ('Maersk Line', 5, '23AV', '', 15),
       ('Mediterranean Shipping Company', 6, '39A', '54', 23),
       ('CMA CGM', 7, '45W', '13Q', 20);
INSERT INTO shippers(name, street_id, house_number, flat_number, price_per_kilogram)
VALUES ('USPS', 1, '23A/2', '', 15);

INSERT INTO stores(name, street_id, house_number, flat_number)
VALUES ('South', 1, '23Q', ''),             -- 1
       ('Mechta', 1, '32L', '23'),          -- 2
       ('White Wind', 2, '43F', ''),        -- 3
       ('Walmart', 2, '52F', ''),           -- 4
       ('Macy', 2, '1A', '23A'),            -- 5
       ('Amazon', 3, '102', '91'),          -- 6
       ('Costco', 3, '85', '13'),-- 7
       ('Home Depot', 4, 'A20', ''),        -- 8
       ('Target', 5, '32F', '95'),          -- 9
       ('IPoint', 6, 'A125', ''),           -- 10
       ('Best Buy', 6, 'B84', ''),-- 13
       ('Public Market', 6, 'O6CAW', '94'), -- 14
       ('Dollar Tree', 7, 'P51', '12'),
       ('Rite Aid', 8, 'IS1', '32'),
       ('Kohi', 8, '8A', '63'),
       ('Verizon Wireless', 9, '9QE', '11'),
       ('YUM! Brands', 10, 'AM12/3', ''),
       ('Meijer', 10, 'WE1', ''),
       ('Ace Hardware', 11, '9F', '31'),
       ('Nordstrom', 12, '01A2', '94B'),
       ('Sears Holdings', 13, '11Z', 'Z-3'),
       ('7-Eleven', 13, '155', ''),
       ('Ross', 13, '94', 'I2'),
       ('Subway', 14, '56', 'QE2'),
       ('Gap', 14, '43', '25F'),
       ('L Brands', 15, '99', '123'),
       ('Menard', 16, 'M3', ''),
       ('Southeastern Grocers', 16, 'W2', 'T2'),
       ('Health Mart', 17, 'A2', 'O3'),
       ('Good Neighbor', 18, '4', ''),
       ('Hy-Vee', 19, 'ZA', '12'),
       ('AuZone', 20, '95', 'A2');

INSERT INTO fit_project_store.public.employees(full_name, street_id, house_number, flat_number, date_of_birth,
                                               working_position_id, store_id)
VALUES ('Kinsley Reeves', 1, '206A', '43', '27/09/1932', 1, 1),      --1
       ('Monserrat Swanson', 2, '203B', '11', '28/10/1932', 2, 1),   -- 2
       ('Benjamin Lee', 1, '13', '', '09/11/1936', 3, 2),            -- 3
       ('Skye Fleming', 3, '52F', '23', '27/02/1941', 4, 2),         --4
       ('Theresa Sanchez', 4, '41', 'C1', '18/08/1948', 2, 3),-- 5
       ('Lily Harris', 5, 'V405', '', '11/03/1952', 1, 3),-- 6
       ('Piper Wall', 6, '52', '5', '22/06/1953', 3, 4),-- 7
       ('Bailee Yang', 2, '55', '31', '01/10/1957', 2, 4),-- 8
       ('Essence Galvan', 7, '123', '1', '13/12/1968', 4, 5),        -- 9
       ('Cesar Fox', 1, '24', '', '08/05/1969', 2, 5),               -- 10
       ('Antoine Conner', 9, '63', '53', '26/06/1969', 1, 6),        -- 11
       ('Amaris Petersen', 10, '1f', '6', '10/10/1969', 3, 7),--12
       ('Francesca Douglas', 4, '62A', '111', '25/01/1973', 4, 7),--13
       ('Urijah Cunningham', 5, '12', '113', '06/04/1973', 2, 8),    -- 14
       ('Athena Huffman', 10, 'P5', '52', '01/07/1975', 1, 9),-- 15
       ('Selena Russell', 11, '12T', '96', '02/06/1976', 4, 9),      -- 16
       ('Teagan Young', 12, '9K', '1O2', '15/10/1982', 3, 10),       -- 17
       ('Jakobe Forbes', 14, '1GF', '23', '16/05/1985', 2, 11),      -- 18
       ('Andy Keith', 15, '9J', '51', '08/09/1986', 1, 10),          -- 19
       ('Alexa Mcneil', 16, 'PA2', 'I2', '19/04/1988', 4, 12),       -- 20
       ('Asher Russo', 11, '42A', '12', '12/10/1989', 2, 13),        -- 21
       ('Preston Sparks', 2, '35G', '95', '26/04/1993', 3, 12),      --22
       ('Sage Moore', 4, 'AS2', '44', '08/02/1994', 4, 14),-- 23
       ('Alfred Pineda', 9, '9OL', '', '24/10/1994', 1, 15),--24
       ('Kylee Ellison', 17, '4F', '15', '06/02/1998', 2, 16),       --25
       ('Kyan Benton', 18, '91Z', '63', '17/09/1931', 3, 17),        --26
       ('Kendra Harrington', 19, '23L', '24A', '05/04/1932', 4, 18), --27
       ('Bridget Haney', 20, '55/5', '63V', '10/01/1934', 2, 17),    -- 28
       ('Erin Raymond', 11, '39AB', '', '10/05/1934', 3, 19),        -- 29
       ('Derek Conley', 5, '9O/1', '8A', '22/08/1934', 4, 20),--30
       ('Evie Roberson', 7, '94/1', '9K', '09/10/1941', 1, 21),--31
       ('Kimberly Melton', 9, '53', '5F', '25/12/1941', 2, 22),      --32
       ('Maxim Pope', 4, '82F', '', '08/05/1942', 3, 23),            --33
       ('Joseph Archer', 6, '95F', '9', '17/07/1945', 2, 24),        -- 34
       ('Jude Reeves', 4, 'Z03', '45', '01/05/1953', 1, 25),         -- 35
       ('Shaniya French', 9, '10A', '40', '26/05/1953', 3, 19),-- 36
       ('Dania Mora', 2, '9JC', '12', '07/12/1954', 2, 20),-- 37
       ('Eugene Ortega', 14, '43B', 'Z2', '08/09/1955', 2, 21),      -- 38
       ('Shea Noble', 21, '92/F', '', '16/12/1957', 1, 17),          -- 39
       ('Jaydan White', 24, '52F/2', '63F', '24/06/1960', 3, 22); --40

INSERT INTO phones(owner_id, phone_number)
VALUES (1, '559-851-5114'),
       (2, '559-851-9715'),
       (3, '559-851-1810'),
       (4, '559-851-7464'),
       (5, '559-851-1868'),
       (6, '559-851-0604'),
       (7, '559-851-6414'),
       (8, '559-851-0996'),
       (9, '559-851-5591'),
       (10, '559-851-2731'),
       (11, '559-851-0378'),
       (12, '559-851-0369'),
       (13, '559-851-0069'),
       (14, '559-851-0196'),
       (15, '559-851-6666'),
       (16, '559-851-4264'),
       (17, '559-851-8784'),
       (18, '559-851-7766'),
       (19, '559-851-3288'),
       (20, '559-851-7348'),
       (21, '559-851-6962'),
       (22, '559-851-5355'),
       (23, '559-851-9820'),
       (24, '559-851-8625'),
       (25, '559-851-9681'),
       (26, '559-851-8569'),
       (27, '559-851-5522'),
       (28, '559-851-9040'),
       (29, '559-851-0505'),
       (30, '559-851-6388'),
       (31, '559-851-7297'),
       (32, '559-851-7067'),
       (33, '559-851-8709'),
       (34, '559-851-0731'),
       (35, '559-851-5641'),
       (36, '559-851-0375'),
       (37, '559-851-2041'),
       (38, '559-851-0999'),
       (39, '559-851-4087'),
       (40, '559-851-9565');

INSERT INTO fit_project_store.public.products(name, category_id, type_id, manufacturer_id)
VALUES ('iPhone 11 128Gb Slim Box черный', 2, 1, 27),                        -- 1 ЗАМЕНИТЬ ЭТИМ ПРОИЗВОДИТЕЛЯ
       ('Samsung Galaxy A32 4/128Gb черный', 2, 1, 28),                      -- 2
       ('Apple Watch Series 7 45 мм черный', 2, 2, 29),                      -- 3
       ('Huawei Watch GT 2 Sport 46 mm LTN-B19 черный', 2, 2, 30),           -- 4
       ('PocketBook 616 черный', 2, 3, 27),                                  -- 1
       ('Kindle PaperWhite 2018 8Gb черный', 2, 3, 32),                      -- 5
       ('S&M для Xiaomi Mi Band 3', 2, 5, 33),                               -- 6
       ('Garmin 010-12820-10 для Garmin MARQ', 2, 5, 27),                    -- 1
       ('MM313ZM MagSafe для Apple iPhone 13 Pro Max прозрачный', 2, 6, 29), -- 2
       ('X-Game XG-S096 для POCO X3/X3 Pro черный', 2, 6, 30),               --3
       ('USB Type-C - Lightning 1 м', 2, 7, 31),                             --4
       ('USB Type-C 1.5 м EP-DG930IBRGRU', 2, 7, 28),                        --1
       ('240KX белый', 1, 8, 33),--6
       ('210KO белый', 1, 8, 34),--7
       ('GA-B379 SLUL серебристый', 1, 9, 35),                               -- 8
       ('RB37A5200SA серебристый', 1, 9, 36),                                -- 9
       ('F-12B8WDS7 белый', 1, 10, 37),                                      -- 10
       ('HW60-BP10929A белый', 1, 10, 27),                                   -- 1
       ('VCC4520S3R/XEV красный', 1, 11, 29),                                -- 2
       ('Karcher VC 3 Premium белый', 1, 11, 31),                            -- 4
       ('PIR 2430K черный-серый', 1, 12, 39),                                -- 12
       ('VT-1215 розовый', 1, 12, 40),                                       -- 13
       ('Aspire 3 A315-34 NX.HE3ER.006', 3, 13, 41),                         -- 14
       ('V14-ADA 82C6S03900 серый', 3, 13, 42),                              -- 15
       ('MacBook Air 13 MGN63 серый', 3, 13, 27),                            --- 1
       ('KPB-132GR 15.6 серый', 3, 14, 44),                                  -- 17
       ('Lite 15.6 черный', 3, 14, 45),                                      -- 18
       ('KCB-160 15.6 черный', 3, 14, 46); -- 19

INSERT INTO warehouses(name, attached_store_id, street_id, house_number, flat_number)
VALUES ('Warehouse 1', 1, 1, '1F', ''),
       ('Warehouse 2', 2, 1, '10S', '1'),
       ('Warehouse 3', 3, 2, '5A', '52'),
       ('Warehouse 4', 4, 2, '93A/4', ''),
       ('Warehouse 5', 5, 2, '91B/2', '13F'),
       ('Warehouse 6', 6, 3, '9D', '55'),
       ('Warehouse 7', 7, 3, '10I', '14'),
       ('Warehouse 8', 1, 4, '91B', '15'),
       ('Warehouse 9', 2, 1, '1A', '16'),
       ('Warehouse 10', 9, 5, 'Y2', '22'),
       ('Warehouse 11', 8, 4, '19O', '21'),
       ('Warehouse 12', 10, 6, '6C', '20'),
       ('Warehouse 13', 11, 6, '8C', '50'),
       ('Warehouse 14', 12, 6, '9L', '31'),
       ('Warehouse 15', 13, 7, '10P', '26');

INSERT INTO seasons(name)
VALUES ('Summer'),
       ('Autumn'),
       ('Spring'),
       ('Winter');


INSERT INTO account_numbers(company_name)
VALUES ('FIO Sharp'), -- 1
       ('FBS Fast'),  -- 2
       ('FTW Venom'), -- 3
       ('FJS FLY'); -- 4
INSERT INTO account_numbers(company_name)
VALUES (''); --5


INSERT INTO offline_customers(id, full_name, phone_number, account_number_id)
VALUES (1, 'Jamison Wong', '620-714-6970', 1),
       (3, 'Keely Lam', '620-714-9370', 2),
       (5, 'Alexander Maxwell', '620-714-7883', 3),
       (7, 'Riya Harvey', '620-714-1935', 4),
       (9, 'Jane Mays', '620-714-7576', 4),
       (11, 'Sharon Stone', '620-714-3720', 4),
       (13, 'Nia Hurley', '620-714-2558', 4),
       (15, 'Nehemiah Owens', '620-714-4865', 1),
       (17, 'Magdalena Cherry', '620-714-0112', 2),
       (19, 'Bethany Horton', '620-714-8552', 4),
       (21, 'Lilly Burnett', '620-714-6906', 4),
       (23, 'Danny Mckinney', '620-714-4522', 3),
       (25, 'Konner Marshall', '620-714-7838', 4),
       (27, 'Abraham Salinas', '620-714-2791', 2);

INSERT INTO online_customers(id, full_name, phone_number, account_id, date_of_birth, account_number_id)
VALUES (2, 'Ryland Bolton', '719-314-9167', 1, '24/03/1933', 1),
       (4, 'Gianni Herrera', '719-314-4131', 2, '06/03/1934', 2),
       (6, 'Caroline Cooper', '719-314-5863', 3, '11/08/1937', 3),
       (8, 'Skyla Burgess', '719-314-3205', 4, '26/08/1942', 4),
       (10, 'Bryson Huber', '719-314-8371', 5, '15/06/1944', 5),
       (12, 'Desmond Ho', '719-314-2067', 6, '25/08/1944', 5),
       (14, 'Kali Cervantes', '719-314-3295', 7, '14/11/1947', 5),
       (16, 'Isis Kemp', '719-314-3094', 8, '16/02/1951', 5),
       (18, 'Ivan Munoz', '719-314-0260', 9, '25/02/1952', 5),
       (20, 'Deborah Garza', '719-314-3233', 10, '30/09/1952', 1),
       (22, 'Kylie Ward', '719-314-1852', 11, '07/12/1956', 2),
       (24, 'Rachel Hardin', '719-314-5552', 12, '06/05/1958', 3),
       (26, 'Caitlyn Ibarra', '719-314-3436', 13, '13/02/1959', 5),
       (28, 'Tiana Singleton', '719-314-0637', 14, '20/05/1959', 5);

INSERT INTO cards(card_number, bank_name, card_type, expiration_date, cvv_code, owner_id)
VALUES ('4539023350992024', 'Kaspi Bank', 'debit', CURRENT_DATE, 312, 2),
       ('4024007157360990', 'Halyk Bank', 'credit', CURRENT_DATE, 132, 4),
       ('4929031737098728', 'Center Credit', 'debit', CURRENT_DATE, 345, 6),
       ('4532018760591736', 'Forte Bank', 'credit', CURRENT_DATE, 678, 10),
       ('4929409188446267', 'Kaspi Bank', 'debit', CURRENT_DATE, 012, 8),
       ('5217433347175581', 'Halyk Bank', 'credit', current_date, 210, 12),
       ('5457678112431119', 'Forte Bank', 'debit', CURRENT_DATE, 202, 14),
       ('5503185280456914', 'Halyk Bank', 'credit', CURRENT_DATE, 205, 16),
       ('6011010951394231', 'Center Credit', 'debit', CURRENT_DATE, 892, 18),
       ('6011621475629546', 'Forte Bank', 'credit', CURRENT_DATE, 024, 20),
       ('6011361525987756', 'Kaspi Bank', 'debit', CURRENT_DATE, 042, 22),
       ('6011956024411214', 'Center Credit', 'credit', CURRENT_DATE, 952, 24),
       ('6011652576432274', 'Kaspi Bank', 'debit', CURRENT_DATE, 865, 26),
       ('3453630976333542', 'Halyk Bank', 'credit', CURRENT_DATE, 879, 28);

SELECT *
FROM stores;
SELECT *
FROM products;

INSERT INTO store_inventory(store_id, product_id, remainded_quantity, last_date_revision, last_date_product_update,
                            minimum_product_quantity, product_price)
VALUES (1, 29, 50, CURRENT_DATE, CURRENT_DATE, 10, 1000),
       (2, 29, 50, CURRENT_DATE, CURRENT_DATE, 10, 1050),
       (3, 29, 50, CURRENT_DATE, CURRENT_DATE, 10, 1010),
       (1, 30, 50, CURRENT_DATE, CURRENT_DATE, 10, 800),
       (2, 30, 50, CURRENT_DATE, CURRENT_DATE, 10, 900),
       (3, 30, 50, CURRENT_DATE, CURRENT_DATE, 10, 850),
       (1, 31, 50, CURRENT_DATE, CURRENT_DATE, 10, 555),
       (2, 31, 50, CURRENT_DATE, CURRENT_DATE, 10, 500),
       (3, 31, 50, CURRENT_DATE, CURRENT_DATE, 10, 510),
       (1, 32, 50, CURRENT_DATE, CURRENT_DATE, 10, 200),
       (2, 32, 50, CURRENT_DATE, CURRENT_DATE, 10, 300),
       (3, 32, 50, CURRENT_DATE, CURRENT_DATE, 10, 250),
       (1, 33, 50, CURRENT_DATE, CURRENT_DATE, 10, 100),
       (2, 33, 50, CURRENT_DATE, CURRENT_DATE, 10, 90),
       (3, 33, 50, CURRENT_DATE, CURRENT_DATE, 10, 95),
       (1, 34, 50, CURRENT_DATE, CURRENT_DATE, 10, 85),
       (2, 34, 50, CURRENT_DATE, CURRENT_DATE, 10, 90),
       (3, 34, 50, CURRENT_DATE, CURRENT_DATE, 10, 85),
       (1, 35, 50, CURRENT_DATE, CURRENT_DATE, 10, 10),
       (2, 35, 50, CURRENT_DATE, CURRENT_DATE, 10, 9),
       (3, 35, 50, CURRENT_DATE, CURRENT_DATE, 10, 11),
       (1, 36, 50, CURRENT_DATE, CURRENT_DATE, 10, 15),
       (2, 36, 50, CURRENT_DATE, CURRENT_DATE, 10, 20),
       (3, 36, 50, CURRENT_DATE, CURRENT_DATE, 10, 18),
       (1, 37, 50, CURRENT_DATE, CURRENT_DATE, 10, 40),
       (2, 37, 50, CURRENT_DATE, CURRENT_DATE, 10, 45),
       (3, 37, 50, CURRENT_DATE, CURRENT_DATE, 10, 50),
       (1, 38, 50, CURRENT_DATE, CURRENT_DATE, 10, 30),
       (2, 38, 50, CURRENT_DATE, CURRENT_DATE, 10, 33),
       (3, 38, 50, CURRENT_DATE, CURRENT_DATE, 10, 40),
       (1, 39, 50, CURRENT_DATE, CURRENT_DATE, 10, 15),
       (2, 39, 50, CURRENT_DATE, CURRENT_DATE, 10, 18),
       (3, 39, 50, CURRENT_DATE, CURRENT_DATE, 10, 20),
       (1, 40, 50, CURRENT_DATE, CURRENT_DATE, 10, 17),
       (2, 40, 50, CURRENT_DATE, CURRENT_DATE, 10, 18),
       (3, 40, 50, CURRENT_DATE, CURRENT_DATE, 10, 20),
       (1, 41, 50, CURRENT_DATE, CURRENT_DATE, 10, 500),
       (2, 41, 50, CURRENT_DATE, CURRENT_DATE, 10, 550),
       (3, 41, 50, CURRENT_DATE, CURRENT_DATE, 10, 560),
       (1, 42, 50, CURRENT_DATE, CURRENT_DATE, 10, 600),
       (2, 42, 50, CURRENT_DATE, CURRENT_DATE, 10, 666),
       (3, 42, 50, CURRENT_DATE, CURRENT_DATE, 10, 650),
       (1, 43, 50, CURRENT_DATE, CURRENT_DATE, 10, 350),
       (1, 44, 50, CURRENT_DATE, CURRENT_DATE, 10, 400);



INSERT INTO order_tracking(departure_city_id, current_city_id, arrival_city_id, last_date_update, description,
                           order_status_id)
VALUES (1, 1, 2, CURRENT_DATE, 'Заказ принят', 1), -- 1
       (2, 2, 1, CURRENT_DATE, 'Заказ принят', 1), -- 2
       (2, 2, 3, CURRENT_DATE, 'Заказ принят', 1), -- 3
       (3, 3, 1, CURRENT_DATE, 'Заказ принят', 1), -- 4
       (3, 3, 2, CURRENT_DATE, 'Заказ принят', 1); -- 5

INSERT INTO shipper_tracking(shipper_id, tracking_number)
VALUES (1, 1),
       (2, 2),
       (2, 3);
-- Заполнить warehouse_manufacturer_audit

-- Заполнить store_warehouse_audit

-- Заполнить warehouse_inventory


INSERT INTO account_bill(account_number_id, monthly_payment, month_number)
VALUES (1, 15, 3),
       (5, 0, 0),
       (2, 10, 5),
       (5, 0, 0);
INSERT INTO account_bill(account_number_id, monthly_payment, month_number)
VALUES (5, 0, 0);

INSERT INTO offline_orders(id, tracking_number, purchase_date, payment_type, customer_id, arrived_warehouse_id,
                           total_price, arrival_date, employee_id, season_id, weight, account_bill_id)
VALUES (get_order_id(true), 1, CURRENT_DATE, 'ACCOUNT', 1, 1, 2000, CURRENT_DATE + 3, 1, 4, 3, 3),
       (get_order_id(true), 2, CURRENT_DATE, 'CASH', 3, 2, 3000, CURRENT_DATE + 5, 2, 4, 4.3, 4);

INSERT INTO online_orders(id, tracking_number, purchase_date, payment_type, arrived_warehouse_id, total_price,
                          season_id, arrival_date, shipper_id, customer_id, shipper_price, weight, account_bill_id)
VALUES (get_order_id(false),3,CURRENT_DATE,'ACCOUNT',1,1500,4,CURRENT_DATE + 3,3,2,30,2.1,5),
       (get_order_id(false),4,CURRENT_DATE,'CREDIT',2,2000,4,CURRENT_DATE + 1,2,4,40,1.5,6),
       (get_order_id(false),5,CURRENT_DATE,'DEBIT',1,1550,4,CURRENT_DATE + 10,3,4,20,4.2,7);

INSERT INTO online_order_products(online_order_id, product_id, quantity) VALUES (2,29,1),
                                                                                (2,33,4),
                                                                                (2,35,7),
                                                                                (4,30,2),
                                                                                (4,36,9),
                                                                                (6,41,1),
                                                                                (6,38,1),
                                                                                (6,29,1);


INSERT INTO offline_order_products(offline_order_id, product_id, quantity) VALUES (1,41,1),
                                                                                  (1,29,1),
                                                                                  (1,35,50),
                                                                                  (3,30,3),
                                                                                  (3,33,4),
                                                                                  (3,32,1);


