# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.target.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- set provider = iscsi.target.provider %}
    {%- if iscsi.kernel.mess_with_kernel and provider in iscsi.config.kmodule %}
include:
  - {{ sls_service_install }}

iscsi-target-kernel-install-file-line:
  file.line:
    - onlyif: {{ iscsi.config.name.modprobe and 'text' in iscsi.config.kmodule[provider] }}
    - name: {{ iscsi.config.name.modprobe }}
    - content: {{ data.config.kmodule[provider]['text'] }}
    - require_in:
      - cmd: iscsi-target-kernel-install-file-line
    - backup: True

iscsi-target-kernel-install-cmd-run:
        {%- if not iscsi.target.enabled %}
  cmd.run:
    - name: {{ iscsi.kernel.modunload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - onlyif: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
    - mode: delete
        {%- else %}
    - mode: ensure
    - after: autoboot_delay.*$
  cmd.run:
    - name: {{ iscsi.kernel.modload }} {{ iscsi.config.kmodule[provider]['name'] }}
    - unless: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
        {%- endif %}
    - require:
      - file: iscsi-target-kernel-install-file-line
    - require_in:
      - sls: {{ sls_service_install }}

    {%- endif %}
