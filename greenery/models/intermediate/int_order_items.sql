{{
    config(
        materialized = 'table'
    )
}}
/*
Grain/primary key : One row per order_item_id
*/

select 
    orders.order_id 
    , orders.created_at as order_created_at 
    , orders.order_cost 
    , orders.shipping_cost as order_shipping_cost 
    , orders.status as order_status
    , orders.order_total 
    , orders.estimated_delivery_at as order_estimated_delivery_at 
    , orders.delivered_at as order_delivered_at 
    , case when promo.promo_id is not null then true else false end as order_has_promo
    , promo.discount as promo_discount
    , promo.status as promo_status
    , order_item.product_id 
    , order_item.quantity as order_product_quantity 
    , product.name 
    , product.price

from {{ ref('stg_postgres__orders')}} orders

left join {{ ref('stg_postgres__promos')}} promo
    on orders.promo_id = promo.promo_id 

left join {{ ref('stg_postgres__order_items')}} order_item
    on orders.order_id = order_item.order_id 

left join {{ ref('stg_postgres__products')}} product
    on order_item.product_id = product.product_id 