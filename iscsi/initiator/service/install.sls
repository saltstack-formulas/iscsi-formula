# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.initiator.config.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_install }}

    {%- if grains.os_family in ('FreeBSD',) %}

iscsi-initiator-service-install-file-line-freebsd:
  file.line:
    - name: {{ iscsi.config.name.modprobe }}
    - content: 'ctld_env="-u"'
    - backup: True
        {%- if iscsi.initiator.enabled %}
    - create: True
    - mode: ensure
    - after: 'autoboot_delay.*'
        {%- else %}
    - mode: delete
        {%- endif %}
    {%- endif %}

    {%- set servicename = iscsi.config.servicename[iscsi.initiator.provider] %}
iscsi-initiator-service-install-service-running:
        {%- if not iscsi.initiator.enabled %}
  service.dead:
    - name: {{ servicename }}
    - enable: False
        {%- else %}
  service.running:
    - name: {{ servicename }}
    - enable: True
    - onfail_in:
      - test: iscsi-initiator-service-install-check-status
    - watch:
      - file: iscsi-initiator-config-install-file-managed
        {%- endif %}
        {%- if servicename is iterable and servicename is not string %}
    - names: {{ servicename|json }}
          {%- else %}
    - name: {{ servicename }}
        {%- endif %}
    - require:
      - sls: {{ sls_config_install }}

iscsi-initiator-service-install-check-status:
  test.show_notification:
    - text: |
        In certain circumstances the iscsi initiator service will not start.
        * your configuration file may be incorrect.
        * your kernel was upgraded but not activated by reboot
            'systemctl enable {{ servicename }}' && reboot
    - unless: {{ grains.os_family in ('MacOS', 'Windows') }}   #maybe not needed but no harm
  cmd.run:
    - names:
      - journalctl -xe -u {{ servicename }} || true
      - systemctl status {{ servicename }} -l || true
      - /sbin/lsmod 2>/dev/null || true
      - ls /var/lib/iscsi/nodes 2>/dev/null || true
      - ls /sys/class/iscsi_session 2>/dev/null || true
    - onlyif: test -x /usr/bin/systemctl || test -x /bin/systemctl || test -x /sbin/systemctl
