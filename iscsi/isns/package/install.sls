# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.isns.config.install' %}
{%- set sls_service_install = tplroot ~ '.isns.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_install }}
  - {{ sls_service_install }}

    {%- if iscsi.isns.pkgs.unwanted %}
        {%- for pkg in iscsi.isns.pkgs.unwanted %}

iscsi-isns-package-install-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_service_install }}

        {%- endfor %}
    {%- endif %}
    {%- if iscsi.isns.pkgs.wanted %}
        {%- for pkg in iscsi.isns.pkgs.wanted %}

iscsi-isns-package-install-{{ pkg }}-installed:
  pkg.installed:
    - name: {{ pkg }}
        {%- if iscsi.isns.pkghold %}
    - hold: {{ iscsi.isns.pkghold }}
        {%- endif %}
    - reload: True
    - require_in:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_service_install }}

        {%- endfor %}
    {%- endif %}
