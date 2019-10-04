# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.isns.config.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}

iscsi-isns-service-clean-service-dead:
  service.dead:
    - name: {{ iscsi.config.servicename[iscsi.isns.provider] }}
    - enable: False
    - require_in:
      - sls: {{ sls_config_clean }}
