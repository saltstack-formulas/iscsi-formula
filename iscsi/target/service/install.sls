# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.target.config.install' %}
{%- set sls_package_install = tplroot ~ '.target.package.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_install }}
  - {{ sls_package_install }}

    {%- if grains.os_family == 'FreeBSD' %}
iscsi-target-service-install-file-line-freebsd:
  file.line:
    - name: {{ iscsi.config.name.modprobe }}
    - content: 'ctld_env="-u"'
    - backup: True
        {%- if iscsi.target.enabled %}
    - create: True
    - mode: ensure
    - after: 'autoboot_delay.*'
        {%- else %}
    - mode: delete
        {%- endif %}
    {%- endif %}

    {%- set servicename = iscsi.config.servicename[iscsi.target.provider] %}
iscsi-target-service-install-service-running:
        {%- if not iscsi.target.enabled %}
  service.dead:
        {%- if servicename is iterable and servicename is not string %}
    - names: {{ servicename|json }}
          {%- else %}
    - name: {{ servicename }}
        {%- endif %}
    - enable: True
    - enable: False
        {%- else %}
  service.running:
        {%- if servicename is iterable and servicename is not string %}
    - names: {{ servicename|json }}
          {%- else %}
    - name: {{ servicename }}
        {%- endif %}
    - enable: True
    - onfail_in:
      - test: iscsi-target-service-install-check-status
            {%- if iscsi.config.data[iscsi.target.provider|string] %}
    - require:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_package_install }}
    - watch:
      - file: iscsi-target-config-install-file-managed
            {%- endif %}
        {%- endif %}
    - unless: {{ grains.os in ('Amazon', 'MacOS') }}
    - onlyif: {{ iscsi.target.enabled }}

iscsi-target-service-install-check-status:
  test.show_notification:
    - text: |
        In certain circumstances the iscsi target service will not start.
        * your configuration file may be incorrect.
        * your kernel was upgraded but not activated by reboot
          {%- if servicename is iterable and servicename is not string %}
                 {%- for svc in servicename %}
            'systemctl enable {{ svc }}' && reboot
                 {%- endfor %}
          {%- else %}
            'systemctl enable {{ servicename }}' && reboot
          {%- endif %}
  cmd.run:
    - names:
          {%- if servicename is iterable and servicename is not string %}
                 {%- for svc in servicename %}
      - journalctl -xe -u {{ svc }} || true
      - systemctl status {{ svc }} -l || true
                 {%- endfor %}
          {%- else %}
      - journalctl -xe -u {{ servicename }} || true
      - systemctl status {{ servicename }} -l || true
          {%- endif %}
      - echo "--enabled? {{ iscsi.target.enabled }} --"
      - /sbin/lsmod 2>/dev/null || true
    - onlyif: test -x /usr/bin/systemctl || test -x /bin/systemctl || test -x /sbin/systemctl
