# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.initiator.service.install' %}
{%- set sls_package_install = tplroot ~ '.initiator.package.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if iscsi.config.data[iscsi.initiator.provider|string] %}

include:
  - {{ sls_service_install }}
  - {{ sls_package_install }}

iscsi-initiator-config-install-file-managed:
  file.managed:
    - name: {{ iscsi.config.name[iscsi.initiator.provider] }}
    - source: {{ files_switch([iscsi.initiator.provider ~ '.tmpl'],
                              lookup='iscsi-initiator-config-install-file-managed',
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
    - require:
      - sls: {{ sls_package_install }}
    - context:
      data: {{ iscsi.config.data[iscsi.initiator.provider|string]|json }}
      component: initiator

    {%- endif %}
