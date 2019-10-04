# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.initiator.config.clean' %}
{%- set sls_service_clean = tplroot ~ '.initiator.service.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_config_clean }}
  - {{ sls_service_clean }}

    {%- for pkg in [iscsi.initiator.pkgs.wanted, iscsi.initiator.pkgs.unwanted] %}
        {%- if pkg %}

iscsi-initiator-package-clean-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require:
      - sls: {{ sls_config_clean }}
      - sls: {{ sls_service_clean }}

        {%- endif %}
    {% endfor %}
