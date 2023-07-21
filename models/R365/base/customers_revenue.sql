{{
  config(
    materialized='view'
  )
}}

with revenue as (
    select * from {{ ref('revenue')}}
),

customers as (
    select * from {{ ref('customers')}}
)

select cast(customer_id as string) as customer_id, number_of_orders as revenue from customers 
union all
select contract_id, contract_line_item_quantity from revenue