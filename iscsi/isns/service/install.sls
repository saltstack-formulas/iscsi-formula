# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.isns.config.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

    {%- set provider = iscsi.isns.provider %}
    {%- set servicename = iscsi.config.servicename[provider] %}
include:
  - {{ sls_config_install }}

iscsi-isns-service-install-service-running:
        {%- if not iscsi.isns.enabled %}
  service.dead:
    - name: {{ servicename }}
    - enable: False
        {%- else %}
  service.running:
    - name: {{ servicename }}
    - enable: True
    - onfail_in:
      - test: iscsi-isns-service-install-failure-explanation
    - require:
      - sls: {{ sls_config_install }}
    - watch:
      - file: iscsi-isns-config-install-file-managed-isnsd
        {%- endif %}
        {%- if servicename is iterable and servicename is not string %}
    - names: {{ servicename|json }}
        {%- else %}
    - name: {{ servicename }}
        {%- endif %}
        {%- if iscsi.kernel.mess_with_kernel and provider in iscsi.config.kmodule %}
            {%- if 'name' in iscsi.config.kmodule[provider] %}
    - onlyif: {{ iscsi.kernel.modquery }} {{ iscsi.config.kmodule[provider]['name'] }}
            {%- endif %}
        {%- endif %}

iscsi-isns-service-install-failure-explanation:
  test.show_notification:
    - text: |
        In certain circumstances the iscsi isns service will not start.
        * your configuration file may be incorrect.
        * your kernel was upgraded but not activated by reboot
            'systemctl enable {{ servicename }}' && reboot
    - unless: {{ grains.os_family in ('MacOS', 'Windows') }}   #maybe not needed but no harm
  cmd.run:
    - names:
      - journalctl -xe -u {{ servicename }} || true
      - systemctl status {{ servicename }} -l || true
    - onlyif: test -x /usr/bin/systemctl || test -x /bin/systemctl || test -x /sbin/systemctl
