{{
  config(
    materialized='table'
  )
}}

select 
    contract_line_item_quantity
    ,contract_id
    ,contract_line_item_id
    ,contract_line_item_price
 from {{ source('intacct_dummy', 'rdm_contract_line_items') }}
    WHERE TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) < TIMESTAMP('2023-07-07')