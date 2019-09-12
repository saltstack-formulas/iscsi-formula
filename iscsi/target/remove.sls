# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "iscsi/map.jinja" import iscsi with context %}

  {%- set provider = iscsi.server.provider %}
  {%- set data = iscsi.target[provider|string] %}

iscsi_target_service_dead:
  file.line:
    - name: {{ data.man5.svcloadfile }}
    - content: {{ data.man5.svcloadtext }}
    - backup: True
    - mode: delete
  service.dead:
    - enable: False
  {%- if data.man5.kmodule %}
    - onlyif: {{ iscsi.kernel.modquery }} {{ data.man5.kmodule }}
  {%- endif %}

  {%- if iscsi.kernel.mess_with_kernel and data.man5.kmodule and data.man5.kmoduletext %}
iscsi_target_kernel_module_{{ data.man5.kmodule }}_removed:
  file.line:
    - name: {{ iscsi.kernel.modloadfile }}
    - content: {{ data.man5.kmoduletext }}
    - backup: True
    - mode: delete
  cmd.run:
    - name: {{ iscsi.kernel.modunload }} {{ data.man5.kmodule }}
    - onlyif: {{ iscsi.kernel.modquery }} {{ data.man5.kmodule }}
    - require:
      - iscsi_target_service_dead
    - require_in:
      - iscsi_target_service_config_removed
  {%- endif %}

  {%- for pkg in [iscsi.server.pkgs.unwanted, iscsi.server.pkgs.unwanted] %}
iscsi_target_wanted_pkgs_{{ pkg }}_removed:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - file: iscsi_target_service_config_removed
  {% endfor %}

iscsi_target_service_config_removed:
  file.absent:
    - name: {{ data.man5.config }}
    - onlyif: test -f {{ data.man5.config }}
