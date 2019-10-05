# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.isns.service.clean' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

include:
  - {{ sls_service_clean }}

    {%- for pkg in iscsi.isns.pkgs.wanted %}
        {%- if pkg %}

iscsi-isns-package-clean-{{ pkg }}-removed:
  pkg.purged:
    - name: {{ pkg }}
    - require:
      - sls: {{ sls_service_clean }}

        {%- endif %}
    {% endfor %}
