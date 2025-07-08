INSERT INTO customers (first_name, last_name, address, city, state, zip, phone, email, notes)
VALUES 
('John', 'Doe', '123 Elm St', 'Memphis', 'TN', '38101', '901-555-1234', 'john.doe@example.com', ''),
('Jane', 'Smith', '456 Oak Ave', 'Marion', 'AR', '72364', '870-555-5678', 'jane.smith@example.com', 'VIP Client'),
('Alice', 'Walker', '78 Pine St', 'West Memphis', 'AR', '72301', '870-555-1001', 'alice@example.com', 'Prefers weekend service'),
('Brian', 'Nguyen', '920 Lakeshore Blvd', 'Memphis', 'TN', '38103', '901-555-2222', 'brian.nguyen@example.com', ''),
('Carla', 'Lopez', '421 Maple Ave', 'Marion', 'AR', '72364', '870-555-3003', 'carla@example.com', 'Requires bilingual technician');

INSERT INTO devices (device_type, brand)
VALUES 
('Camera', 'Hikvision'),
('Door Sensor', 'Ring'),
('Alarm System', 'ADT'),
('Smart Lock', 'August'),
('Camera', 'Arlo');


INSERT INTO items (item_name, description, price, quantity)
VALUES 
('Mounting Bracket', 'Wall mount for cameras', 25.00, 100),
('Power Adapter', '12V adapter for security camera', 15.00, 50),
('Outdoor Camera Mount', 'Compatible with Arlo devices', 30.00, 25),
('Sensor Battery', 'Long-life lithium pack', 8.00, 100);


INSERT INTO products (product_name, description, price, quantity)
VALUES 
('Smart Hub', 'Home automation controller', 99.99, 30),
('Doorbell Camera', 'Wi-Fi video doorbell', 149.99, 40),
('Wireless Doorbell', '2-way talk and night vision', 99.99, 20),
('Window Sensor Pack', 'Includes 4 sensors', 49.99, 30);


INSERT INTO technicians (technician_name, notes)
VALUES 
('Mike Johnson', 'Specializes in security systems'),
('Sasha Reed', 'Handles smart home integration'),
('Lamar Taylor', 'Experienced with commercial setups'),
('Anita Bell', 'Handles residential installs and troubleshooting');

INSERT INTO orders (customer_id, order_date, order_cost)
VALUES
(1, '2025-06-01', 199.98),
(3, '2025-06-02', 149.99);

INSERT INTO order_line (order_id, product_id, quantity, cost)
VALUES
(1, 1, 1, 99.99),
(1, 2, 2, 49.99),
(2, 1, 1, 99.99);

INSERT INTO installs (customer_id, technician_id, device_id, description, cost, install_date)
VALUES 
(1, 1, 1, 'Installed 4 exterior cameras', 1200.00, '2024-09-10'),
(2, 2, 2, 'Mounted door sensor and tested app', 300.00, '2024-09-14'),
(1, 1, 1, 'Installed full alarm system', 850.00, '2025-04-01'),
(2, 2, 2, 'Installed smart lock with app configuration', 275.00, '2025-04-03'),
(3, 1, 3, 'Mounted two exterior cameras with cloud setup', 640.00, '2025-04-04');


INSERT INTO repairs (customer_id, device_id, issue_description, repair_cost, repair_date)
VALUES 
(1, 1, 'Camera IR not working at night', 150.00, '2024-10-02'),
(1, 1, 'Faulty motion sensor', 125.00, '2025-05-01'),
(2, 2, 'Lock not responding to app commands', 90.00, '2025-05-05');

INSERT INTO repair_items (repair_id, item_id, quantity, cost)
VALUES
(1, 2, 2, 16.00),
(2, 2, 1, 8.00);


INSERT INTO invoices (customer_id, invoice_date, subtotal, tax_amount, total)
VALUES 
(1, '2024-10-05', 1200.00, 123.00, 1323.00),
(2, '2024-10-08', 300.00, 30.75, 330.75),
(1, '2025-06-05', 'Unpaid', 1065.00, 109.31, 1174.31),
(2, '2025-06-06', 'Partially Paid', 365.00, 37.46, 402.46);

INSERT INTO payments (invoice_id, payment_amount, payment_method, payment_date)
VALUES 
(1, 1323.00, 'Credit Card', '2024-10-06 10:00:00'),
(2, 200.00, 'Cash', '2024-10-09 09:30:00'), -- Partial
(2, 200.00, 'Credit Card', '2025-06-07 14:45:00');

INSERT INTO invoice_details (invoice_id, repair_id, install_id, order_id, cost)
VALUES
(1, 1, 1, 1, 1174.31),
(2, 2, 2, NULL, 402.46);
