insert into {{ source ('intacct_dummy', 'rdm_int_usage_revenue') }}
(
select
    contract_line_item_price,
    contract_line_item_quantity,
    revenue_amount_usd,
    revenue_recognize_date,
    contract_id,
    revenue_id,
    software_product_id,
    is_recurring
from {{ source ('intacct_dummy', 'rdm_int_usage_revenue') }}
{{ limit_data_in_dev('timestamp_trunc(_PARTITIONTIME, day)') }}
)