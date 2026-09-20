
{{ config(
    materialized = 'incremental',
    unique_key = 'created_at'
) }}

select * from ({{ source('staging', 'bookings') }})

{% if is_incremental() %}
  where created_at > (select max(created_at) from {{ this }})
{% endif %}
