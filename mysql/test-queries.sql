-- test queries
SELECT 
    i.item_id,
    i.item_name,
    SUM(ri.quantity) AS total_quantity_used,
    SUM(ri.cost * ri.quantity) AS total_cost
FROM 
    repair_items ri
JOIN 
    items i ON ri.item_id = i.item_id
GROUP BY 
    i.item_id, i.item_name
ORDER BY 
    i.item_id;
--
SELECT
	r.repair_date,
    i.item_id,
    i.item_name,
    SUM(ri.quantity) AS total_quantity_used,
    SUM(ri.cost * ri.quantity) AS total_cost
FROM 
    repair_items ri
JOIN 
    items i ON ri.item_id = i.item_id
JOIN repairs r on ri.repair_id = r.repair_id
GROUP BY 
    r.repair_date, i.item_id, i.item_name
ORDER BY 
    r.repair_date, i.item_id;
    
--
SELECT
	r.repair_date,
    c.first_name,
    c.last_name,
    i.item_id,
    i.item_name,
    SUM(ri.quantity) AS total_quantity_used,
    SUM(ri.cost * ri.quantity) AS total_cost
FROM 
    repair_items ri
JOIN 
    items i ON ri.item_id = i.item_id
JOIN repairs r on ri.repair_id = r.repair_id
JOIN customers c on r.customer_id = c.customer_id
GROUP BY 
    r.repair_date, i.item_id, i.item_name, c.first_name, c.last_name
ORDER BY 
    r.repair_date, c.first_name, i.item_id;
    
--
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(r.repair_cost) AS total_spent
FROM 
    customers c
JOIN 
    repairs r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, customer_name
ORDER BY 
    total_spent DESC
LIMIT 1;

--
SELECT 
    i.item_id,
    i.item_name,
    COUNT(DISTINCT ri.repair_id) AS repairs_used_in
FROM 
    items i
LEFT JOIN 
    repair_items ri ON i.item_id = ri.item_id
GROUP BY 
    i.item_id, i.item_name
ORDER BY 
    repairs_used_in DESC, i.item_id;

