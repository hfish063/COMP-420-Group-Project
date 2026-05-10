-- View for an order item
CREATE VIEW order_item_view AS
SELECT
    oi.order_item_id,
    o.order_id,
    o.order_date,
    o.status,
    oi.order_item_type,
    p.name as product_name,
    jd.repair_type
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN jobs j
    ON oi.job_id = j.job_id
LEFT JOIN job_details jd
    ON j.job_id = jd.job_id;

-- View for product inventory
-- Usage: SELECT * FROM product_inventory_view WHERE store_id = ...
CREATE VIEW product_inventory_view AS
SELECT 
    p.name,
    p.price,
    c.name,
    b.name,
    i.inventory_id,
    i.quantity
FROM inventory i
JOIN products p 
    ON i.id = p.id
JOIN categories c 
    ON p.id = c.id
JOIN brands b 
    ON p.id = b.id;

-- View for a repair job
CREATE VIEW repair_job_view AS
SELECT
    j.job_id,
    e.f_name as employee_name,
    jd.description,
    jd.repair_type,
    j.price,
    j.ongoing,
    c.client_id,
    c.f_name as client_first_name,
    c.l_name as client_last_name,
    c.email as client_email,
    c.address as client_address
FROM jobs j
LEFT JOIN employees e
    ON j.assigned_employee_id = e.employee_id
LEFT JOIN job_details jd
    ON j.job_id = jd.job_id
LEFT JOIN clients c
    ON j.client_id = c.client_id;