Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### Week 1 SQL Query Assignment

- 1. SELECT count(USER_GUID) FROM DEV_DB.DBT_SHARADALNUGLOBALPCOM.STG_POSTGRES__USERS;
- 2. WITH hourly_orders 
AS (SELECT date_part(hour, created_at) AS hour_bucket, count(*) AS cnt FROM DEV_DB.DBT_SHARADALNUGLOBALPCOM.STG_POSTGRES__ORDERS
GROUP BY hour_bucket)
SELECT avg(cnt) FROM hourly_orders;
- 3. WITH delivery_time as
(
SELECT ORDER_ID, CREATED_AT, DELIVERED_AT, STATUS, TIMEDIFF(day,CREATED_AT,DELIVERED_AT) as delivery_days, TIMEDIFF(hour,CREATED_AT,DELIVERED_AT) as delivery_hour
FROM DEV_DB.DBT_SHARADALNUGLOBALPCOM.STG_POSTGRES__ORDERS
WHERE STATUS = 'delivered'
)
SELECT avg(delivery_days) as avg_delivery_days, avg(delivery_hour) as avg_delivery_hours from delivery_time;
- 4. with total_orders as
(SELECT USER_ID, count(distinct ORDER_ID) as total_orders
FROM DEV_DB.DBT_SHARADALNUGLOBALPCOM.STG_POSTGRES__ORDERS
GROUP BY USER_ID
),
three_plus_orders as
(
select count(USER_ID) as no_of_users ,'3+' as no_of_purchase from total_orders
group by total_orders
having total_orders > 2
)

select count(USER_ID) as no_of_users ,total_orders::varchar as no_of_purchase from total_orders
group by total_orders
having total_orders in (1,2)
union
select sum(no_of_users) as no_of_users, no_of_purchase from three_plus_orders
group by no_of_purchase;

- 5. with hourly_sessions 
as (select date_part(hour, created_at) as hour_bucket, count(distinct SESSION_ID) as cnt from 
DEV_DB.DBT_SHARADALNUGLOBALPCOM.STG_POSTGRES__EVENTS
group by hour_bucket)
select avg(cnt) as avg_sessions_per_hour from hourly_sessions;
