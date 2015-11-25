{% from "python/map.jinja" import python2, sls_block with context %}

{% from "python/map.jinja" import python2, sls_block with context %}

{% if python2.lookup.pip == True -%}
python_pip_install:
  pkg.installed:
    {{ sls_block(python2.pip.opts) }}
    - name: {{ python2.lookup.pip_package }}
{% endif -%}

{% for package, settings in python2.packages.items() -%}
{{ package }}_pip_install:
  pip.installed:
    - name: {{ package }}
    - require:
      - pkg: python_pip_install
{% if settings.config is defined and settings.config != None -%}
    {{ settings.config|yaml() }}
{% endif %}
{% endfor -%}
