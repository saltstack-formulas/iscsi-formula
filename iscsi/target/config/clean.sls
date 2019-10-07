# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_clean = tplroot ~ '.target.package.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

    {%- if iscsi.config.data[iscsi.target.provider|string] %}

include:
  - {{ sls_package_clean }}

iscsi-target-config-clean-file-absent:
  file.absent:
    - unless: {{ grains.os in ('Amazon', 'MacOS') }}
    - name: {{ iscsi.config.name[iscsi.target.provider|string] }}
    - watch_in:
        - sls: {{ sls_package_clean }}

    {%- endif %}
