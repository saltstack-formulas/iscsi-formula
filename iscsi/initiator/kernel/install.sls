# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.initiator.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- set provider = iscsi.initiator.provider %}
    {%- if provider in iscsi.config.kmodule %}
include:
  - {{ sls_service_install }}

iscsi-initiator-kernel-install-file-line:
  file.line:
    - onlyif: iscsi.config.name.modprobe and 'text' in iscsi.config.kmodule[provider] }}
    - name: {{ iscsi.config.name.modprobe }}
    - content: {{ iscsi.config.kmodule[provider]['text'] }}
    - backup: True
        {%- if not iscsi.initiator.enabled %}
    - mode: delete
  cmd.run:
    - name: {{ iscsi.kernel.modunload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - onlyif: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
        {%- else %}
    - create: True
    - mode: ensure
    - match: None
  cmd.run:
    - name: {{ iscsi.kernel.modload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - unless: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
        {%- endif %}
    - require:
      - file: iscsi-initiator-kernel-install-file-line
    - require_in:
      - sls: {{ sls_service_install }}

    {%- endif %}
