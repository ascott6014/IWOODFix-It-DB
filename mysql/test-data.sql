-- States
INSERT INTO states (state_id, state_name, abbreviation)
VALUES
(1, 'Arkansas', 'AR'),
(2, 'Tennessee', 'TN'),
(3, 'Tennessee', 'TN'),
(4, 'Missouri', 'MO'),
(5, 'Texas', 'TX');

-- Employees
INSERT INTO employees (employee_id, first_name, last_name, phone, email)
VALUES
(1, 'Grace', 'Hopper', '555-1001', 'grace.hopper@example.com'),
(2, 'Alan', 'Turing', '555-1002', 'alan.turing@example.com'),
(3, 'Ada', 'Lovelace', '555-1003', 'ada.lovelace@example.com'),
(4, 'Linus', 'Torvalds', '555-1004', 'linus.torvalds@example.com'),
(5, 'Margaret', 'Hamilton', '555-1005', 'margaret.hamilton@example.com');

-- Addresses
INSERT INTO addresses (employee_id, home_address, city, state_id, zip, is_active)
VALUES
(1, '123 Main St', 'Little Rock', 1, '72201', TRUE),
(2, '456 Pine St', 'Memphis', 2, '38103', TRUE),
(3, '789 Oak Ave', 'Nashville', 3, '37201', TRUE),
(4, '321 Cedar Blvd', 'St. Louis', 4, '63101', TRUE),
(5, '654 Maple Rd', 'Dallas', 5, '75201', TRUE);

-- customers
INSERT INTO customers (first_name, last_name, address, city, state, zip, phone, email, notes)
VALUES
('Alice', 'Johnson', '100 Oak St', 'Little Rock', 'AR', '72201', '555-1234', 'alice.johnson@example.com', 'Prefers evening calls'),
('Bob', 'Smith', '220 Pine Ave', 'Memphis', 'TN', '38103', '555-5678', 'bob.smith@example.com', 'Requested paper invoices'),
('Charlie', 'Davis', '301 Maple Rd', 'Nashville', 'TN', '37201', '555-8765', 'charlie.davis@example.com', 'Has a service discount'),
('Diana', 'Miller', '17 Cedar Blvd', 'St. Louis', 'MO', '63101', '555-4321', 'diana.miller@example.com', 'Follow-up on installation'),
('Ethan', 'Taylor', '88 Elm St', 'Dallas', 'TX', '75201', '555-2468', 'ethan.taylor@example.com', 'Needs repair on item 102');

-- items
INSERT INTO items (item_name, item_color, item_model, description, cost, price, quantity, sell_item, repair_item, install_item)
VALUES
('Smart Thermostat', 'White', 'ST100', 'Wi-Fi enabled thermostat with touchscreen', 75.00, 149.99, 20, TRUE, FALSE, TRUE),
('LED Light Panel', 'Silver', 'LP200', 'Energy-efficient light panel for ceiling install', 45.50, 99.00, 35, TRUE, FALSE, TRUE),
('Security Camera', 'Black', 'SC300', 'Outdoor camera with motion detection', 60.00, 129.99, 15, TRUE, TRUE, TRUE),
('Smart Door Lock', 'Gray', 'DL400', 'Fingerprint-enabled electronic lock', 85.00, 169.99, 10, TRUE, TRUE, TRUE),
('Wall Outlet Kit', 'White', 'WO500', 'Standard electrical outlet with USB ports', 12.75, 29.99, 50, TRUE, FALSE, TRUE),
('Router', 'Black', 'RT600', 'High-speed dual-band router', 40.00, 89.99, 25, TRUE, TRUE, FALSE),
('Smoke Detector', 'White', 'SD700', 'Battery-operated smoke and carbon monoxide detector', 18.00, 39.99, 40, TRUE, TRUE, TRUE),
('Speaker System', 'Black', 'SP800', 'Bluetooth speaker system with subwoofer', 55.00, 119.99, 12, TRUE, TRUE, FALSE),
('Cable Bundle', 'Gray', 'CB900', '10-pack of HDMI cables', 20.00, 45.00, 100, TRUE, FALSE, FALSE),
('Backup Battery', 'Black', 'BB1000', 'Portable power backup for devices', 30.00, 69.99, 18, TRUE, FALSE, FALSE);



-- repairs 
INSERT INTO repairs (customer_id, item_id, problem, solution, repair_cost, repair_date)
VALUES
(3, 1, 'Thermostat screen frozen', 'Reset firmware', 45.00, CURRENT_DATE),
(4, 3, 'Camera lens cracked', 'Replaced lens', 60.00, CURRENT_DATE);

-- installs
INSERT INTO installs (customer_id, employee_id, description, cost, install_date)
VALUES
(5, 2, 'Install smart door lock', 85.00, CURRENT_DATE),
(1, 4, 'Install LED ceiling panel', 99.00, CURRENT_DATE);

-- orders
insert into orders (customer_id, order_date, order_total)
values (1, current_date(), null);

-- order items
-- First item
INSERT INTO order_items (order_id, item_id, quantity, total_price)
VALUES (1, 1, 2, NULL);

-- Second item
INSERT INTO order_items (order_id, item_id, quantity, total_price)
VALUES (1, 2, 1, NULL);

UPDATE order_items
SET quantity = 3
WHERE order_item_id = 1;

-- show triggers;



