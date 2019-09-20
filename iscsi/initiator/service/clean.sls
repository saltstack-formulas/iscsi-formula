# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.initiator.config.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}

iscsi-initiator-service-clean-service-dead:
  service.dead:
    - name: {{ iscsi.config.servicename[iscsi.initiator.provider] }}
    - enable: False
    - require_in:
      - sls: {{ sls_config_clean }}

    {%- if grains.os_family == 'FreeBSD' %}

iscsi-initiator-service-clean-file-line-freebsd:
  file.line:
    - name: {{ iscsi.config.name.modprobe }}
    - content: 'ctld_env="-u"'
    - mode: delete
    - backup: True

    {%- endif %}
