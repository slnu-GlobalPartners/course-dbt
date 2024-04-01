{{
    config(
        materialized = 'table'
    )
}}

with page_views as (
    select * from {{ ref('stg_postgres__events')}}
    where EVENT_TYPE = 'page_view'
)
,
add_to_carts as (
    select * from {{ ref('stg_postgres__events')}}
    where EVENT_TYPE = 'add_to_cart'
)
,
checkouts as (
    select * from {{ ref('stg_postgres__events')}}
    where EVENT_TYPE = 'checkout'
)
,
package_shippeds as (
    select * from {{ ref('stg_postgres__events')}}
    where EVENT_TYPE = 'package_shipped'
)
,
products as
(
select * from {{ ref('stg_postgres__products')}}
)

select 
page_views.PRODUCT_ID
, TO_DATE(page_views.created_at) as created_date
, products.NAME as product_name
, count(distinct page_views.event_id) as no_of_page_views
, count(distinct add_to_carts.event_id) as no_of_add_to_carts
, count(distinct checkouts.event_id) as no_of_checkouts
, count(distinct package_shippeds.event_id) as no_of_package_shippeds
from products 
left join page_views on page_views.product_id = products.product_id
left join add_to_carts on add_to_carts.product_id=products.product_id
left join checkouts on checkouts.product_id = products.product_id
left join package_shippeds on package_shippeds.product_id = products.product_id
group by 1,2,3
