{%- set is_recurring_values = [true, false] -%}
with
    payments as (
        select *
        from
            {{ source("intacct_dummy", "rdm_int_straightlined_revenue") }}
            {{ limit_data_in_dev("timestamp_trunc(_PARTITIONTIME, day)") }}
    ),
    pivoted as (
        select
            contract_id,
            {% for is_recurring in is_recurring_values -%}
                sum(
                    case
                        when is_recurring is {{ is_recurring }}
                        then revenue_amount_usd
                        else 0
                    end
                ) as {{ is_recurring }}_amount
                {%- if not loop.last -%}, {%- endif %}
            {% endfor -%}
        from payments
        group by 1
    )
select *
from pivoted
