{{
    config(
        materialized='table',
    )
}}

with products as (

    select * from {{ ref('stg_jaffle_products') }}

)

select
    product_id,
    product_name,
    product_type,
    product_description,
    product_price,
    is_food_item,
    is_drink_item
from products
