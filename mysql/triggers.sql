use iwood;


-- updates invoice status upon payment
DELIMITER $$
CREATE TRIGGER update_invoice_status_after_payment
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
  DECLARE total_paid DECIMAL(10,2);

  -- Sum of all payments made toward this invoice
  SELECT SUM(payment_amount)
  INTO total_paid
  FROM payments
  WHERE invoice_id = NEW.invoice_id;

  -- Update the invoice status
  UPDATE invoices
  SET status = CASE
    WHEN total_paid >= total THEN 'Paid'
    WHEN total_paid > 0 THEN 'Partially Paid'
    ELSE 'Unpaid'
  END
  WHERE invoice_id = NEW.invoice_id;
END$$
DELIMITER ;

-- creates log for item price upon item creation
DELIMITER $$

CREATE TRIGGER log_price_on_insert_item
AFTER INSERT ON items
FOR EACH ROW
BEGIN
  INSERT INTO item_price_log (
    item_id, price, start_date
  )
  VALUES (
    NEW.item_id, NEW.price, CURDATE()
  );
END$$

DELIMITER ;

-- creates log for item price upon update to item
DELIMITER $$

CREATE TRIGGER log_price_on_update_item
AFTER UPDATE ON items
FOR EACH ROW
BEGIN
  IF OLD.price <> NEW.price THEN
    INSERT INTO item_price_log (
      item_id, price, start_date
    )
    VALUES (
      NEW.item_id, NEW.price, CURDATE()
    );
  END IF;
END$$

DELIMITER ;

-- updates customer visits on order
CREATE TRIGGER log_order_visit
AFTER INSERT ON orders
FOR EACH ROW
INSERT INTO customer_visits (customer_id, visit_type)
VALUES (NEW.customer_id, 'Order');

-- updates customer visits on repair
CREATE TRIGGER log_repair_visit
AFTER INSERT ON repairs
FOR EACH ROW
INSERT INTO customer_visits (customer_id, visit_type)
VALUES (NEW.customer_id, 'Repair');

-- updates customer visits on install
CREATE TRIGGER log_install_visit
AFTER INSERT ON installs
FOR EACH ROW
INSERT INTO customer_visits (customer_id, visit_type)
VALUES (NEW.customer_id, 'Install');

-- sets order items total price upon insertion 
DELIMITER //

CREATE TRIGGER calculate_order_item_total_price
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
  DECLARE unit_price DECIMAL(10,2);

  SELECT price INTO unit_price
  FROM items
  WHERE item_id = NEW.item_id;

  SET NEW.total_price = unit_price * NEW.quantity;
END //

DELIMITER ;


-- updates total price for order after update to quantity on order item

DELIMITER //

CREATE TRIGGER recalculate_order_item_total_price
BEFORE UPDATE ON order_items
FOR EACH ROW
BEGIN
  DECLARE unit_price DECIMAL(10,2);

  SELECT price INTO unit_price
  FROM items
  WHERE item_id = NEW.item_id;

  SET NEW.total_price = unit_price * NEW.quantity;
END //

DELIMITER ;

-- updats orders order total after insert to order item
DELIMITER //

CREATE TRIGGER update_order_total_after_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  DECLARE total DECIMAL(10,2);

  SELECT SUM(total_price)
  INTO total
  FROM order_items
  WHERE order_id = NEW.order_id;

  UPDATE orders
  SET order_total = total
  WHERE order_id = NEW.order_id;
END //

DELIMITER ;

-- updates order total after item or quantity is changed
DELIMITER //

CREATE TRIGGER update_order_total_after_update
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
  DECLARE total DECIMAL(10,2);

  SELECT SUM(total_price)
  INTO total
  FROM order_items
  WHERE order_id = NEW.order_id;

  UPDATE orders
  SET order_total = total
  WHERE order_id = NEW.order_id;
END //

DELIMITER ;





