use iwood;
-- 1. Customers
INSERT INTO customers (first_name, last_name, address, city, state, zip, phone, email, notes)
VALUES 
('John', 'Smith', '101 Main St', 'Marion', 'AR', '72364', '555-1111', 'john.smith@example.com', 'Regular customer'),
('Lisa', 'Chan', '202 Elm St', 'West Memphis', 'AR', '72301', '555-2222', 'lisa.chan@example.com', 'First-time customer');

-- 2. States
INSERT INTO states (state_name, abbreviation)
VALUES ('Arkansas', 'AR'), ('Tennessee', 'TN');

-- 3. Federal Tax Log
INSERT INTO federal_tax_log (percentage, start_date, is_active)
VALUES (12.5, NOW(), true);

-- 4. State Tax Log
INSERT INTO state_tax_log (state_id, percentage, start_date)
VALUES (1, 6.5, NOW());

-- 5. Employees and Addresses
INSERT INTO addresses (employee_id, home_address, city, state_id, zip, is_active)
VALUES (1, '300 Oak Ln', 'Marion', 1, '72364', true),
       (2, '400 Pine Ave', 'Memphis', 2, '38103', true);

INSERT INTO employees (first_name, last_name, phone, email, address_id)
VALUES 
('Alice', 'Brown', '555-3333', 'alice.b@example.com', 1),
('Mark', 'Lopez', '555-4444', 'mark.l@example.com', 2);

-- 6. Titles
INSERT INTO titles (title_name, description)
VALUES ('Installer', 'Installs custom woodwork'), ('Technician', 'Handles repairs and diagnostics');

INSERT INTO title_log (title_id, employee_id, start_date)
VALUES (1, 1, NOW()), (2, 2, NOW());

-- 7. Items
INSERT INTO items (item_name, item_color, item_model, description, cost, price, quantity, sell_item, repair_item, install_item)
VALUES 
('Wood Cabinet', 'Mahogany', 'WC-100', 'Custom wood cabinet', 80.00, 150.00, 5, true, false, true),
('Sliding Door', 'White', 'SD-200', 'Interior sliding door', 60.00, 120.00, 3, true, false, true);

-- 8. Item Price Log (trigger will populate as needed)

-- 9. Repairs and Installs
INSERT INTO repairs (customer_id, item_id, problem, solution, repair_cost, repair_date)
VALUES (1, 2, 'Stuck track', 'Lubricated rollers', 30.00, CURDATE());

INSERT INTO installs (customer_id, employee_id, description, cost, install_date)
VALUES (2, 1, 'Installed cabinet in kitchen', 100.00, CURDATE());

-- 10. Orders
INSERT INTO orders (customer_id, order_date, order_cost)
VALUES (1, CURDATE(), 150.00);

-- 11. Invoices
INSERT INTO invoices (customer_id, install_id, repair_id, order_id, invoice_date, subtotal, tax_amount, total)
VALUES (1, NULL, 1, 1, curdate(), 180.00, 10.25, 190.25),
       (2, 1, NULL, NULL, curdate(), 100.00, 6.50, 106.50);

-- 12. Payments (to trigger invoice status update)
INSERT INTO payments (invoice_id, payment_amount, payment_method, payment_date)
VALUES (1, 190.25, 'Credit Card', NOW()),
       (2, 50.00, 'Cash', NOW());

-- 13. Verify invoice status
SELECT invoice_id, status, total FROM invoices;

