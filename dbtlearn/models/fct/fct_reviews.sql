{{
 config(
 materialized = 'incremental',
 on_schema_change='fail'
 )
}}
WITH src_reviews AS (
 SELECT * FROM {{ ref('src_reviews') }}
)
SELECT 
  {{ dbt_utils.generat_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id
   -- dbt_util 을 사용한 고유키 생성 (4컬럼을 병합한거와 같은 효과)
  ,*
 FROM src_reviews
WHERE review_text is not null
{% if is_incremental() %}
 AND review_date > (select max(review_date) from {{ this }})
{% endif %}