INSERT INTO customers (first_name, last_name, address, city, state, zip, phone, email, notes)
VALUES 
('John', 'Doe', '123 Elm St', 'Memphis', 'TN', '38101', '901-555-1234', 'john.doe@example.com', ''),
('Jane', 'Smith', '456 Oak Ave', 'Marion', 'AR', '72364', '870-555-5678', 'jane.smith@example.com', 'VIP Client');

INSERT INTO devices (device_type, brand)
VALUES 
('Camera', 'Hikvision'),
('Door Sensor', 'Ring');

INSERT INTO technicians (technician_name, notes)
VALUES 
('Mike Johnson', 'Specializes in security systems'),
('Sasha Reed', 'Handles smart home integration');

INSERT INTO installs (customer_id, technician_id, device_id, description, cost, install_date)
VALUES 
(1, 1, 1, 'Installed 4 exterior cameras', 1200.00, '2024-09-10'),
(2, 2, 2, 'Mounted door sensor and tested app', 300.00, '2024-09-14');

INSERT INTO repairs (customer_id, device_id, issue_description, repair_cost, repair_date)
VALUES 
(1, 1, 'Camera IR not working at night', 150.00, '2024-10-02');

INSERT INTO items (item_name, description, price, quantity)
VALUES 
('Mounting Bracket', 'Wall mount for cameras', 25.00, 100),
('Power Adapter', '12V adapter for security camera', 15.00, 50);

INSERT INTO products (product_name, description, price, quantity)
VALUES 
('Smart Hub', 'Home automation controller', 99.99, 30),
('Doorbell Camera', 'Wi-Fi video doorbell', 149.99, 40);

INSERT INTO invoices (customer_id, invoice_date, subtotal, tax_amount, total)
VALUES 
(1, '2024-10-05', 1200.00, 123.00, 1323.00),
(2, '2024-10-08', 300.00, 30.75, 330.75);

INSERT INTO payments (invoice_id, payment_amount, payment_method, payment_date)
VALUES 
(1, 1323.00, 'Credit Card', '2024-10-06 10:00:00'),
(2, 200.00, 'Cash', '2024-10-09 09:30:00'); -- Partial
