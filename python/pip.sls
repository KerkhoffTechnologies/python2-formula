{% from "python/map.jinja" import python2, sls_block with context %}

{% if python2.lookup.pip == True -%}
python_pip_install:
  pkg.installed:
    {{ sls_block(python2.pip.opts) }}
    - name: {{ python2.lookup.pip_package }}
{% endif -%}

{% for package, opts in python2.pips.iteritems() -%}
{{ package }}_pip_install:
  pip.installed:
    {{ sls_block(opts) }}
    - name: {{ package }}
    - require:
      - pkg: python_pip_install
{% endfor -%}
