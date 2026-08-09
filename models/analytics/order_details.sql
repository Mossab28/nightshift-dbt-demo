-- order_details: the denormalized view behind every revenue dashboard.
-- Joins orders with customers, products and promotions; consumed by the
-- PowerBI Essential_KPI_Measures dataset downstream.

select
    o.order_id,
    o.order_date,
    o.order_mode,
    o.order_status,
    o.order_amount as order_total,
    o.cost_of_delivery,
    o.delivery_type,
    o.payment_method_code,
    c.customer_id,
    c.cust_first_name,
    c.cust_last_name,
    c.customer_class,
    oi.line_item_id,
    oi.product_id,
    oi.unit_price,
    oi.quantity,
    oi.unit_price * oi.quantity as line_total
from {{ source('order_entry', 'orders') }} o
join {{ source('order_entry', 'customers') }} c on c.customer_id = o.customer_id
join {{ source('order_entry', 'order_items') }} oi on oi.order_id = o.order_id
