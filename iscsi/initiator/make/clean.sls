# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.initiator.service.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

  {%- if iscsi.initiator.make.wanted %}
include:
  - {{ sls_service_clean }}
      {%- for pkg in iscsi.initiator.make.wanted %}

iscsi-initiator-package-make-clean-{{ pkg }}-removed:
  pkg.removed:
    - name: {{ pkg }}
    - require:
      - sls: {{ sls_service_clean }}

      {%- endfor %}
  {%- endif %}
