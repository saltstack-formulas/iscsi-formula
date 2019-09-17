# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.target.config.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}

iscsi-target-service-clean-service-dead
  service.dead:
    - name: {{ iscsi.config.servicename[iscsi.target.provider] }}
    - enable: False
    - require_in:
      - sls: {{ sls_config_clean }}

iscsi-target-service-install-file-line-freebsd:
  file.line:
    - onlyif: {{ grains.os_family == 'FreeBSD' }}
    - name: {{ iscsi.config.name.modprobe }}
    - content: 'ctld_env="-u"'
    - mode: delete
    - backup: True
