# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.initiator.config.install' %}
{%- set sls_service_install = tplroot ~ '.initiator.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_install }}
  - {{ sls_service_install }}

    {%- if iscsi.initiator.pkgs.unwanted %}
        {%- for pkg in iscsi.initiator.pkgs.unwanted %}

iscsi-initiator-package-install-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_service_install }}

        {%- endfor %}
    {%- endif %}
    {%- if iscsi.initiator.pkgs.wanted %}
        {%- for pkg in iscsi.initiator.pkgs.wanted %}

iscsi-initiator-package-install-{{ pkg }}-installed:
  pkg.installed:
    - name: {{ pkg }}
        {%- if iscsi.initiator.pkghold %}
    - hold: {{ iscsi.initiator.pkghold }}
        {%- endif %}
    - reload: True
    - require_in:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_service_install }}

        {%- endfor %}
    {%- endif %}
