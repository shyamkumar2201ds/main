{{
  config(
    materialized='table'
  )
}}

select 
    contract_end_date
    ,contract_start_date
    ,contract_status 
from {{ source('intacct_dummy', 'rdm_contracts') }}
    where TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) < TIMESTAMP('2023-07-10')