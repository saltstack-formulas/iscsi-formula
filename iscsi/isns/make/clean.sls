# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.isns.service.clean' %}
{%- set sls_config_clean = tplroot ~ '.isns.config.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

  {%- if iscsi.isns.make.wanted %}
include:
  - {{ sls_service_clean }}
  - {{ sls_config_clean }}

      {%- for pkg in iscsi.isns.make.wanted %}

iscsi-isns-package-make-clean-{{ pkg }}-removed:
  pkg.removed:
    - name: {{ pkg }}
    - require:
      - sls: {{ sls_service_clean }}
      - sls: {{ sls_config_clean }}

      {%- endfor %}

  {%- endif %}
