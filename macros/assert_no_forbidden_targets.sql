{% macro assert_no_forbidden_targets() %}

  {% set forbidden = ['bad'] %}
  {% set violations = [] %}

  {% if execute %}
    {% for node in graph.nodes.values()
         | selectattr("resource_type", "in", ["model", "seed", "snapshot"]) %}
      {% for value in [node.config.database, node.config.schema] %}
        {% if value and value | lower in forbidden %}
          {% do violations.append(node.unique_id ~ " -> " ~ value) %}
        {% endif %}
      {% endfor %}
    {% endfor %}

    {% if violations | length > 0 %}
      {{ exceptions.raise_compiler_error(
          "Forbidden database/schema override:\n  " ~ violations | join("\n  ")) }}
    {% endif %}

    {% do log("No forbidden database/schema overrides found.", info=True) %}
  {% endif %}

{% endmacro %}