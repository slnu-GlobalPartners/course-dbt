{{
    config(
        materialized = 'table'
    )
}}


with sessions_events_prodicts_agg as (

    select * from {{ ref('int_sessions_events_products_agg')}}
)

, products as (

    select * from {{ ref('stg_postgres__products')}}
)



select sessions_events_prodicts_agg.product_id
, sessions_events_prodicts_agg.session_id
, sessions_events_prodicts_agg.ADD_TO_CARTS
, sessions_events_prodicts_agg.CHECKOUTS
, sessions_events_prodicts_agg.PACKAGE_SHIPPEDS
, sessions_events_prodicts_agg.PAGE_VIEWS
, products.name
, products.price
from sessions_events_prodicts_agg 
join products on products.product_id = sessions_events_prodicts_agg.product_id
