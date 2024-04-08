{% macro warehouse_resize(size) %}

  ALTER WAREHOUSE {{ target.warehouse }} SET WAREHOUSE_SIZE = {{ size }};

{% endmacro %}