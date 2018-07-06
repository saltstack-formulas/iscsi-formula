# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "iscsi/map.jinja" import iscsi with context %}

iscsi_initiator_service_dead:
  file.line:
    - name: {{ man5.svcloadfile }}
    - content: {{ man5.svcloadtext }}
    - backup: True
    - mode: delete
  service.dead:
    - enable: False
{% if iscsi.kernel.mess_with_kernel and man5.kmodule %}
    - onlyif: {{ "%s %s".format(iscsi.kernel.modquery, man5.kmodule) }}
{%- endif -%}

{%- set kmodule = iscsi.client['provider']['man5']['kmodule'] -%}
{% if iscsi.kernel.mess_with_kernel and man5.kmodule and man5.kloadtext %}
iscsi_initiator_kernel_module_{{ man5.kmodule }}_removed:
  file.line:
    - name: {{ iscsi.kernel.modloadfile }}
    - content: {{ man5.kloadtext }}
    - backup: True
    - mode: delete
  cmd.run:
    - name: {{ iscsi.initiator.kernel.modunload }}
    - onlyif: {{ iscsi.initiator.kernel.modquery }}
    - require:
      - iscsi_initiator_service_dead
    - require_in:
      - iscsi_initiator_service_config_removed
{% endif %}

  {% for pkg in [iscsi.client.pkgs.unwanted, iscsi.client.pkgs.unwanted] %}
    {% if pkg %}
iscsi_initiator_wanted_pkgs_{{ pkg }}_removed:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - file: iscsi_initiator_service_config_removed
    {% endif %}
  {% endfor %}

iscsi_initiator_service_config_removed:
  file.absent:
    - name: {{ iscsi.initiator.man5.config }}
    - onlyif: test -f {{ iscsi.initiator.man5.config }}
