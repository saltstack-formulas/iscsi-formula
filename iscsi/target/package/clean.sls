# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.target.config.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}

    {%- for pkg in [iscsi.target.pkgs.wanted, iscsi.target.pkgs.unwanted] %}

iscsi-target-package-clean-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require:
      - sls: {{ sls_config_clean }}

    {% endfor %}
