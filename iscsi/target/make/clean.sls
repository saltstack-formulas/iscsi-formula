# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

  {%- if iscsi.target.make.wanted and grains.os_family not in ('Arch',) %}
      {%- for pkg in iscsi.target.make.wanted %}
          {%- if pkg %}

iscsi-target-package-make-clean-{{ pkg }}-removed:
  pkg.removed:
    - name: {{ pkg }}

          {%- endif %}
      {%- endfor %}
  {%- endif %}
