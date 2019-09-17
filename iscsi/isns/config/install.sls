# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.isns.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_service_install }}

iscsi-isns-config-install-file-managed-isnsd:
  file.managed:
    - onlyif: {{ iscsi.config.name['isns'] }}
    - name: {{ iscsi.config.name['isns'] }}
    - source: {{ files_switch([iscsi.isns.provider ~ '.tmpl'],
                              lookup='iscsi-isns-config-install-file-managed',
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
    - watch_in:
      - service: iscsi-isns-service-install-service-running
    - context:
      data: {{ iscsi.config.data[iscsi.isns.provider|string]|json }}
      component: isns
      provider: {{ iscsi.isns.provider|string }}

    {%- if 'isnsadm' in iscsi.config.name and iscsi.config.name['isnsadm'] %}
iscsi-isns-config-install-file-managed-isnsadm:
  file.managed:
    - name: {{ iscsi.config.name['isnsadm'] }}
    - source: {{ files_switch([iscsi.isns.provider ~ '.tmpl'],
                              lookup='iscsi-isns-config-install-file-managed',
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
    - watch_in:
      - service: iscsi-isns-service-install-service-running
    - context:
      data: {{ iscsi.config.data[iscsi.isns.provider|string]|json }}
      component: isns
      provider: {{ iscsi.isns.provider|string }}
    {%- endif %}

    {%- if 'isnsdd' in iscsi.config.name and iscsi.config.name['isnsdd'] %}
iscsi-isns-config-install-file-managed-isnsdd:
  file.managed:
    - onlyif: {{ iscsi.config.name['isnsdd'] }}
    - name: {{ iscsi.config.name['isnsdd'] }}
    - source: {{ files_switch([iscsi.isns.provider ~ '.tmpl'],
                              lookup='iscsi-isns-config-install-file-managed',
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
    - watch_in:
      - service: iscsi-isns-service-install-service-running
    - context:
      data: {{ iscsi.config.data[iscsi.isns.provider|string]|json }}
      component: isns
      provider: {{ iscsi.isns.provider|string }}
    {%- endif %}