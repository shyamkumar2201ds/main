{{
  config(
    materialized='view'
  )
}}

with line_item as (
    select * from {{ ref('rdm_contract_line_items')}}
),

usage_revenue as (
    select * from {{ ref('rdm_int_usage_revenue')}}
),

customer_data as (
    select
         l.contract_line_item_quantity
        ,l.contract_id
        ,l.contract_line_item_id
        ,l.contract_line_item_price
        ,r.revenue_amount_usd
        ,r.{{ dollars_to_inr_1() }} as amount_1                     ---First approach Using Macros
        ,{{ dollars_to_inr('r.revenue_amount_usd',2)}} as amount      ---second approach Using Macros
        ,r.revenue_recognize_date
        ,r.revenue_id
        ,r.software_product_id
        ,r.is_recurring
    from line_item l
        join usage_revenue r on l.contract_id = r.contract_id
)
select * from customer_data
--select contract_id, sum(revenue_amount_usd) as revenue from customer_data group by contract_id
