{{
    config(
        materialized = 'table'
    )
}}

with order_metrics as (
    select * from {{ ref('int_user_orders') }}
)
, users as (
    select * from {{ ref('dim_users') }}
)
, addresses as (
    select * from {{ ref('stg_postgres__addresses') }}
)

select users.USER_GUID as user_id, users.FIRST_NAME, users.LAST_NAME, users.EMAIL,order_metrics.no_of_orders, order_metrics.avg_order_value, order_metrics.latest_order_date
,addresses.ZIPCODE, addresses.STATE, addresses.country
from order_metrics 
join users on order_metrics.user_id = users.USER_GUID
join addresses on addresses.ADDRESS_ID= users.ADDRESS_ID