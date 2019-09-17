# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.initator.service.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_service_clean }}

iscsi-initiator-config-clean-file-absent:
  file.absent:
    - name: {{ iscsi.config.name['initiator'] }}
    - watch_in:
        - sls: {{ sls_service_clean }}
