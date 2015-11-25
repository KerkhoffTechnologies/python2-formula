# VirtualHosts processing
#
# Manages the configuration of virtual environments

{% from 'python/map.jinja' import python2, sls_block with context %}

{%- if python2.lookup.virtualenv == True %}
python_virtualenv_install:
  pip.installed:
    {{ sls_block(python2.virtualenv.opts) }}
    - name: {{ python2.lookup.virtualenv_package }}
    - require:
      - pkg: python_pip_install
{% endif %}

# Managed enabled/disabled state for vhosts
{% for virtualenv, settings in python2.virtualenvs.managed.items() %}
{% if settings.config != None %}
{{ virtualenv }}_setup:
  virtualenv.managed:
    {{ settings.config|yaml() }}
{% endif %}
{% endfor %}


