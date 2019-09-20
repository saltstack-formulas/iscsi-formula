# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.initiator.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- set provider = iscsi.initiator.provider %}
    {%- if iscsi.initiator.loadmodule and iscsi.config.kmodule[provider]['name'] %}
include:
  - {{ sls_service_install }}

iscsi-initiator-kernel-install-file-prepend:
  file.prepend:
    - onlyif: {{ iscsi.config.name.modprobe and iscsi.config.kmodule[provider]['text'] }}
    - name: {{ iscsi.config.name.modprobe }}
    - text: {{ iscsi.config.kmodule[provider]['text'] }}
    - makedirs: True

iscsi-initiator-kernel-install-cmd-run:
        {%- if iscsi.initiator.enabled %}
  cmd.run:
    - name: {{ iscsi.kernel.modload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - unless: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
        {%- else %}
  cmd.run:
    - name: {{ iscsi.kernel.modunload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - onlyif: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
        {%- endif %}
    - require_in:
      - sls: {{ sls_service_install }}

    {%- endif %}
