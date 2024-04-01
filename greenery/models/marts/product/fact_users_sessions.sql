{{
    config(
        materialized = 'table'
    )
}}


with sessions_events_agg as (

    select * from {{ ref('int_sessions_events_agg')}}
)

, users as (

    select * from {{ ref('stg_postgres__users')}}
)

, addresses as (
    select * from {{ ref('stg_postgres__addresses')}}
)

select sessions_events_agg.USER_ID
, sessions_events_agg.session_id
, users.FIRST_NAME
, users.LAST_NAME
, users.EMAIl
, addresses.ADDRESS_ID
, addresses.ZIPCODE
, addresses.STATE
, addresses.COUNTRY
, sessions_events_agg.ADD_TO_CARTS
, sessions_events_agg.CHECKOUTS
, sessions_events_agg.PACKAGE_SHIPPEDS
, sessions_events_agg.PAGE_VIEWS
from sessions_events_agg 
join users on users.USER_GUID = sessions_events_agg.user_id
join addresses on addresses.ADDRESS_ID = users.ADDRESS_ID