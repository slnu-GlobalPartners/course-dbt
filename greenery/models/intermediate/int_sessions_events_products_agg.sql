{{
    config(
        materialized = 'table'
    )
}}

with events as (
    select * from {{ ref ('stg_postgres__events')}}
)

, products_events as (
    select 
        product_id
        , session_id
        , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts
        , sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts
        , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shippeds
        , sum(case when event_type = 'page_view' then 1 else 0 end) as page_views
        , min(CREATED_AT) as first_session_event_at_utc
        , max(CREATED_AT) as last_session_event_at_utc
    from events
    group by 1, 2

)

select * from products_events