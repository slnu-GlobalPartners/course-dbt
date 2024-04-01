{{
  config(
    materialized='table'
  )
}}


SELECT *
FROM {{ ref('stg_postgres__users') }}
