# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.initiator.service.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- set provider = iscsi.initiator.provider %}
    {%- if provider in iscsi.config.kmodule %}
include:
  - {{ sls_service_clean }}

iscsi-initiator-kernel-clean-cmd-run:
  cmd.run:
    - name: {{ iscsi.kernel.modunload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - onlyif: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
    - require:
      - sls: {{ sls_service_clean }}

iscsi-initiator-kernel-clean-file-line:
  file.line:
    - onlyif: {{ iscsi.config.name.modprobe and 'text' in iscsi.config.kmodule[provider] }}
    - name: {{ iscsi.config.name.modprobe }}
    - content: {{ iscsi.config.kmodule[provider]['text'] }}
    - backup: True
    - mode: delete
    - quiet: True

    {%- endif %}
