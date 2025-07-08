drop database if exists iwood;
create database iwood;
use iwood;

create table customers (
	customer_id int primary key auto_increment,
    first_name 	varchar(255) not null,
    last_name 	varchar(255) not null,
    address 	varchar(255) not null,
    city		varchar(255) not null,
    state		varchar(255) not null,
    zip			varchar(10) not null,
    phone		varchar(20) not null,
    email 		varchar(255) not null,
    notes		text
);

create table devices (
	device_id		int primary key auto_increment,
    device_type		varchar(255) not null,
    brand			varchar(255) not null
);

create table technicians (
	technician_id		int primary key auto_increment,
    technician_name		varchar(255) not null,
    notes				text
);

create table installs (
	install_id		int primary key auto_increment,
    customer_id		int not null,
    technician_id	int	not null,
    device_id		int not null,
    description 	text,
    cost			decimal(10,2) not null,
    install_date	date,
    CONSTRAINT installs_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT installs_fk_technicians FOREIGN KEY (technician_id) REFERENCES technicians(technician_id),
    CONSTRAINT installs_fk_devices FOREIGN KEY (device_id) REFERENCES devices(device_id)
);


create table repairs (
	repair_id 			int primary key auto_increment,
    customer_id 		int not null,
    device_id			int not null,
    issue_description	varchar(255) not null,
    repair_cost			decimal(10,2) not null,
    repair_date			date not null,
    CONSTRAINT repairs_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT repairs_fk_devices FOREIGN KEY (device_id) REFERENCES devices(device_id)
);

create table items (
	item_id 		int primary key auto_increment,
    item_name		varchar(255) not null,
    description 	varchar(255) not null,
    price			decimal(10,2) not null,
    quantity		int not null
);

create table item_price_log (
	item_price_log_id		int primary key auto_increment,
    item_id					int not null,
    price					decimal(10,2),
    start_date				date not null,
    end_date				date,
    CONSTRAINT item_price_log_fk_items FOREIGN KEY (item_id) REFERENCES items(item_id)
);

create table repair_items (
	repair_item_id 	int primary key auto_increment,
    repair_id 		int not null,
    item_id 		int not null,
    quantity		int not null,
    cost 			decimal(10,2), -- resarch
    CONSTRAINT repair_items_fk_repairs FOREIGN KEY (repair_id) REFERENCES repairs (repair_id),
    CONSTRAINT repair_items_fk_items FOREIGN KEY (item_id)	REFERENCES items (item_id)
    
);

create table orders (
	order_id 		int primary key auto_increment,
    customer_id		int not null,
    order_date		date not null,
    order_cost		decimal(10,2),
	CONSTRAINT orders_fk_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

create table products (
	product_id		int primary key auto_increment,
    product_name	varchar(255) not null,
    description		varchar(255) not null,
    price			decimal(10,2) not null,
    quantity		int not null
);

create table order_line (
	order_line_id		int primary key auto_increment,
    order_id			int not null,
    product_id			int not null,
    quantity			int not null,
    cost				decimal(10,2),
    CONSTRAINT order_line_fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT order_line_fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

create table product_price_log (
	product_price_log_id		int primary key auto_increment,
    product_id					int not null,
    price						decimal(10,2) not null,
    start_date					date,
    end_date					date,
    CONSTRAINT product_price_log_fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

create table invoices (
	invoice_id		int primary key auto_increment,
    customer_id		int not null,
    invoice_date	date not null,
    status			enum('Unpaid', 'Paid', 'Partially Paid', 'Overdue') default 'Unpaid',
    subtotal		decimal(10,2) not null,
    tax				decimal(10,2) default 10.25 not null,
    tax_amount		decimal(10,2) not null,
    total			decimal(10,2) not null,
    CONSTRAINT invoices_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

create table payments (
	payment_id			int primary key auto_increment,
    invoice_id			int not null,
    payment_amount		decimal(10,2) not null default 0,
    payment_method		varchar(255) not null,
	payment_date		datetime not null,
    CONSTRAINT payments_fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id)    
);

create table invoice_details (
	invoice_detail_id		int primary key auto_increment,
    invoice_id				int not null,
    repair_id				int,
    install_id				int,
    order_id				int,
    cost					decimal(10,2),
    CONSTRAINT invoice_details_fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
    CONSTRAINT invoice_details_fk_repairs FOREIGN KEY (repair_id) REFERENCES repairs (repair_id),
    CONSTRAINT invoice_details_fk_installs FOREIGN KEY (install_id) REFERENCES installs(install_id),
    CONSTRAINT invoice_details_fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Invoice balance view
CREATE VIEW invoice_balances AS
SELECT 
    i.invoice_id,
    i.total,
    COALESCE(SUM(p.payment_amount), 0) AS total_paid,
    (i.total - COALESCE(SUM(p.payment_amount), 0)) AS balance
FROM Invoices i
LEFT JOIN Payments p ON i.invoice_id = p.invoice_id
GROUP BY i.invoice_id, i.total;

-- Invoice balance triggers

DELIMITER $$

CREATE TRIGGER trg_update_invoice_status_after_payment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
  DECLARE totalPaid DECIMAL(10,2);
  DECLARE invoiceTotal DECIMAL(10,2);

  SELECT total INTO invoiceTotal FROM Invoices WHERE invoice_id = NEW.invoice_id;

  SELECT SUM(payment_amount) INTO totalPaid 
  FROM Payments WHERE invoice_id = NEW.invoice_id;

  IF totalPaid >= invoiceTotal THEN
    UPDATE Invoices SET status = 'Paid' WHERE invoice_id = NEW.invoice_id;
  ELSE
    UPDATE Invoices SET status = 'Partially Paid' WHERE invoice_id = NEW.invoice_id;
  END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_recalculate_invoice_status_after_update
AFTER UPDATE ON Payments
FOR EACH ROW
BEGIN
  DECLARE totalPaid DECIMAL(10,2);
  DECLARE invoiceTotal DECIMAL(10,2);

  SELECT total INTO invoiceTotal FROM Invoices WHERE invoice_id = NEW.invoice_id;

  SELECT SUM(payment_amount) INTO totalPaid 
  FROM Payments WHERE invoice_id = NEW.invoice_id;

  IF totalPaid >= invoiceTotal THEN
    UPDATE Invoices SET status = 'Paid' WHERE invoice_id = NEW.invoice_id;
  ELSE
    UPDATE Invoices SET status = 'Partially Paid' WHERE invoice_id = NEW.invoice_id;
  END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER trg_invoice_clear_on_empty_details
AFTER DELETE ON invoice_details
FOR EACH ROW
BEGIN
  DECLARE remaining INT;
  SELECT COUNT(*) INTO remaining FROM invoice_details WHERE invoice_id = OLD.invoice_id;

  IF remaining = 0 THEN
    UPDATE Invoices SET status = 'Unpaid' WHERE invoice_id = OLD.invoice_id;
  END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_log_item_price_change -- Updates item price log when item is updated. Works
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
  IF NEW.price <> OLD.price THEN
    -- Close the previous price log
    UPDATE item_price_log
    SET end_date = CURDATE()
    WHERE item_id = OLD.item_id AND end_date IS NULL;

    -- Insert new price log
    INSERT INTO item_price_log (item_id, price, start_date)
    VALUES (NEW.item_id, NEW.price, CURDATE());
  END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_log_product_price_change -- updates product price log when product is updated
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.price <> OLD.price THEN
    -- Close the previous price log
    UPDATE product_price_log
    SET end_date = CURDATE()
    WHERE product_id = OLD.product_id AND end_date IS NULL;

    -- Insert new price log
    INSERT INTO product_price_log (product_id, price, start_date)
    VALUES (NEW.product_id, NEW.price, CURDATE());
  END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_log_item_price_on_insert -- logs item price upon insert into items works
AFTER INSERT ON items
FOR EACH ROW
BEGIN
  INSERT INTO item_price_log (item_id, price, start_date)
  VALUES (NEW.item_id, NEW.price, CURDATE());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_log_product_price_on_insert -- logs product price upon insert into products
AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO product_price_log (product_id, price, start_date)
  VALUES (NEW.product_id, NEW.price, CURDATE());
END$$

DELIMITER ;


