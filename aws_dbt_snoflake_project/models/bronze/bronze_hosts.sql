{{ config(
    materialized = 'incremental',
    unique_key = 'host_id'
) }}

select * from ({{ source('staging', 'hosts') }})

{% if is_incremental() %}
  where host_id > (select max(host_id) from {{ this }})
{% endif %}
