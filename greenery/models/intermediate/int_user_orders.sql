{{
  config(
    materialized='table'
  )
}}

with orders as (
    select * from {{ ref('dim_orders') }}
)

select user_id, count(distinct order_id) as no_of_orders, (sum(ORDER_TOTAL)/count(distinct order_id)) as avg_order_value,  max(CREATED_AT) as latest_order_date
from orders
group by user_id
