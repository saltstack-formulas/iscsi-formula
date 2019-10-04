# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_clean = tplroot ~ '.initiator.package.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_package_clean }}

iscsi-initiator-config-clean-file-absent:
  file.absent:
    - name: {{ iscsi.config.name[iscsi.initiator.provider|string] }}
    - watch_in:
        - sls: {{ sls_package_clean }}
