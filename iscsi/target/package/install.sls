# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_install = tplroot ~ '.target.config.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_install }}

    {%- if iscsi.target.pkgs.unwanted %}
        {%- for pkg in iscsi.target.pkgs.unwanted %}

iscsi-target-package-install-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - sls: {{ sls_config_install }}

        {%- endfor %}
    {%- endif %}
    {%- if iscsi.target.pkgs.wanted %}
        {%- for pkg in iscsi.target.pkgs.wanted %}

iscsi-target-package-install-{{ pkg }}-installed:
  pkg.installed:
    - name: {{ pkg }}
        {%- if iscsi.target.pkghold %}
    - hold: {{ iscsi.target.pkghold }}
        {%- endif %}
    - reload: True
    - require_in:
      - sls: {{ sls_config_install }}

        {%- endfor %}
    {%- endif %}
