{% macro dollars_to_inr_1() -%}
revenue_amount_usd * 100
{%- endmacro%}

{% macro dollars_to_inr(column_name,decimal_places) -%}
round(1.0 * {{ column_name }} * 100, {{ decimal_places }})
{%- endmacro %}

{% macro limit_data_in_dev(column_name) -%}
where {{ column_name }} < timestamp("2023-07-10")
{%- endmacro %}