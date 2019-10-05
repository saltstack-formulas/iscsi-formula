# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.target.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if iscsi.config.data[iscsi.target.provider|string] %}

include:
  - {{ sls_service_install }}

iscsi-target-config-install-file-managed:
  file.managed:
    - name: {{ iscsi.config.name[iscsi.target.provider] }}
    - source: {{ files_switch([iscsi.target.provider ~ '.tmpl'],
                              lookup='iscsi-target-config-install-file-managed',
                              use_subpath=True
                 )
              }}
    - mode: {{ iscsi.filemode }}
    - user: root
    - group: {{ iscsi.rootgroup }}
    - makedirs: True
    - template: jinja
    - require_in:
      - sls: {{ sls_service_install }}
    - context:
      data: {{ iscsi.config.data[iscsi.target.provider|string]|json }}
      component: target

    {%- endif %}
