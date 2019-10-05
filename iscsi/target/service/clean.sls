# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.target.config.clean' %}
{%- set sls_package_clean = tplroot ~ '.target.package.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}
  - {{ sls_package_clean }}

iscsi-target-service-clean-service-dead:
  service.dead:
    - unless: {{ grains.os in ('Amazon', 'MacOS') }}
    - name: {{ iscsi.config.servicename[iscsi.target.provider] }}
    - enable: False
      {%- if iscsi.config.data[iscsi.target.provider|string] %}
    - watch_in:
      - sls: {{ sls_config_clean }}
      - sls: {{ sls_package_clean }}
      {%- endif %}

    {%- if grains.os_family == 'FreeBSD' %}

iscsi-target-service-clean-file-line-freebsd:
  file.line:
    - name: {{ iscsi.config.name.modprobe }}
    - content: 'ctld_env="-u"'
    - mode: delete
    - backup: True
    - quiet: True
    - watch_in:
      - sls: {{ sls_config_clean }}
      - sls: {{ sls_package_clean }}

    {%- endif %}
