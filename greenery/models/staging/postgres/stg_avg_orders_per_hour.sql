with total_orders 
as (
    select date_part(hour, created_at) as hour_bucket, count(*) as cnt from {{ source('postgres','orders') }} 
    group by hour_bucket
    )
select avg(cnt) as average_orders_by_hour from total_orders