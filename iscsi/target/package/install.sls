# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.target.config.install' %}
{%- set sls_service_install = tplroot ~ '.target.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_install }}
  - {{ sls_service_install }}

    {%- if iscsi.target.pkgs.unwanted %}
        {%- for pkg in iscsi.target.pkgs.unwanted %}

iscsi-target-package-install-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_service_install }}

        {%- endfor %}
    {%- endif %}
    {%- if iscsi.target.pkgs.wanted %}
        {%- for pkg in iscsi.target.pkgs.wanted %}

iscsi-target-package-install-{{ pkg }}-installed:
  pkg.installed:
    - unless: {{ grains.os in ('Amazon', 'MacOS') }}
    - name: {{ pkg }}
        {%- if iscsi.target.pkghold %}
    - hold: {{ iscsi.target.pkghold }}
        {%- endif %}
    - reload: True
    - require_in:
      - sls: {{ sls_config_install }}
      - sls: {{ sls_service_install }}

        {%- endfor %}
    {%- endif %}
