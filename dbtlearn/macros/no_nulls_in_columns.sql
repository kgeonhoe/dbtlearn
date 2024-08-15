{% macro no_nulls_in_columns(model) %}
 SELECT * FROM {{ model }} WHERE -- model 이름에 ref(model) 로 안해도 모델명으로 인식을 한다.
 {% for col in adapter.get_columns_in_relation(model) -%}
 {{ col.column }} IS NULL OR -- or 다음에 for 문의 다음 컬럼이 오게 된다. 
 {% endfor %}
 FALSE --  OR 다음에 FALSE 로 끝내게 됨. 
{% endmacro %}
