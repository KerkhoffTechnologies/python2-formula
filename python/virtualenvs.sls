# VirtualHosts processing
#
# Manages the configuration of virtual environments

{% from 'python/map.jinja' import python2, sls_block with context %}

# Simple path concatenation.
# Needs work to make this function on windows.
{% macro path_join(file, root) -%}
  {{ root ~ '/' ~ file }}
{%- endmacro %}

# Managed enabled/disabled state for vhosts
{% for virtualenv, settings in python2.virtualenvs.managed.items() %}
{% if settings.config != None %}
{{ virtualenv }}_setup:
  virtualenv.managed:
    {{ settings.config|yaml() }}
{% endif %}
{% endfor %}


