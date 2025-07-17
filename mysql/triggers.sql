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

-- updates federal tax log upon insert DOES NOT WORK CHANGE 						CHANGE THAT
DELIMITER $$

CREATE TRIGGER update_old_federal_tax_on_insert
BEFORE INSERT ON federal_tax_log
FOR EACH ROW
BEGIN
  -- Set end_date and deactivate any currently active federal tax record
  UPDATE federal_tax_log
  SET 
    end_date = NEW.start_date,
    is_active = false
  WHERE is_active = true;
END$$

DELIMITER ;
