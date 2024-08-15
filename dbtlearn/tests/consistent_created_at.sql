 SELECT 
    * 
FROM 
    {{ ref('dim_listings_cleansed') }} dim 
    inner join {{ref('fct_reviews')}} fct 
    on dim.listing_id = fct.listing_id
WHERE dim.created_at > fct.review_date
