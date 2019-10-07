# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_clean = tplroot ~ '.isns.package.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_package_clean }}

    {%- if iscsi.config.data[iscsi.isns.provider|string] %}

iscsi-isns-config-clean-file-absent:
  file.absent:
    - name: {{ iscsi.config.name[iscsi.isns.provider] }}
    - watch_in:
        - sls: {{ sls_package_clean }}

    {%- endif %}
    {%- if 'isnsadm' in iscsi.config.data and iscsi.config.data['isnsadm'] %}

iscsi-isns-config-clean-file-absent-isnsadm:
  file.absent:
    - name: {{ iscsi.config.name['isnsadm'] }}
    - watch_in:
        - sls: {{ sls_package_clean }}

    {%- endif %}
    {%- if 'isnsdd' in iscsi.config.data and iscsi.config.data['isnsdd'] %}

iscsi-isns-config-clean-file-absent-isnsdd:
  file.absent:
    - name: {{ iscsi.config.name['isnsdd'] }}
    - watch_in:
        - sls: {{ sls_package_clean }}

    {%- endif %}
