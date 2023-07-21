select 
    is_recurring, 
    ARRAY_AGG(
      STRUCT(
            revenue_id,
            contract_id,
            revenue_recognize_date,
            revenue_amount_usd,
            contract_line_item_quantity,
            contract_line_item_price)
            ) as customer_data
from {{ source ('intacct_dummy', 'rdm_int_straightlined_revenue') }}
    WHERE TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) < TIMESTAMP('2023-07-07') 
    group by is_recurring

/*SELECT 1 AS rollNo, STRUCT("Isha" as name,22 as age,"Pharmacy" as department) AS info
UNION ALL
SELECT 2 AS rollNo, STRUCT("Yash" as name,22 as age,"Mechanical Engineering" as department) AS info
UNION ALL 
SELECT 3 AS rollNo, STRUCT("Siddhi" as name,18 as age,"Metallurgy" as department) AS info
UNION ALL 
SELECT 4 AS rollNo, STRUCT("Kushal" as name,21 as age,"Electrical Engineering" as department) AS info
*/