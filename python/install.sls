{% from "python/map.jinja" import python2, sls_block with context %}

python_install:
  pkg.installed:
    {{ sls_block(python2.package.opts) }}
    - name: {{ python2.lookup.package }}

{%- if python2.lookup.dev == True %}
python_dev_install:
  pkg.installed:
    {{ sls_block(python2.dev.opts) }}
    - name: {{ python2.lookup.dev_package }}
{% endif %}

