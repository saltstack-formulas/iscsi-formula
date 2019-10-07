# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.isns.config.clean' %}
{%- set sls_package_clean = tplroot ~ '.isns.package.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}
  - {{ sls_package_clean }}

iscsi-isns-service-clean-service-dead:
  service.dead:
    - name: {{ iscsi.config.servicename[iscsi.isns.provider] }}
    - enable: False
        {%- if iscsi.config.data[iscsi.isns.provider|string] %}
    - watch_in:
      - sls: {{ sls_config_clean }}
      - sls: {{ sls_package_clean }}
        {%- endif %}
