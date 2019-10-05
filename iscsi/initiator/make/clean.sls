# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.initiator.service.clean' %}
{%- set sls_config_clean = tplroot ~ '.initiator.config.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

  {%- if iscsi.initiator.make.wanted %}
include:
  - {{ sls_service_clean }}
  - {{ sls_config_clean }}

      {%- for pkg in iscsi.initiator.make.wanted %}

iscsi-initiator-package-make-clean-{{ pkg }}-removed:
  pkg.removed:
    - name: {{ pkg }}
    - require:
      - sls: {{ sls_service_clean }}
      - sls: {{ sls_config_clean }}

      {%- endfor %}

  {%- endif %}
