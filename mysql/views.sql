use iwood;
-- VIEWS 

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