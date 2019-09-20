# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.target.service.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_service_clean }}

iscsi-target-config-clean-file-absent:
  file.absent:
    - unless: {{ grains.os in ('Amazon', 'MacOS') }}
    - name: {{ iscsi.config.name['target'] }}
    - watch_in:
        - sls: {{ sls_service_clean }}
