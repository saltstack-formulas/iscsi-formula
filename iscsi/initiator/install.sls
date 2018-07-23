# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "iscsi/map.jinja" import iscsi with context %}

  {%- set provider = iscsi.client.provider -%}
  {%- set data = iscsi.initiator[provider|string] -%}

  {% for pkg in iscsi.client.pkgs.unwanted %}
    {% if pkg %}
iscsi_initiator_unwanted_pkgs_{{ pkg }}:
  pkg.purged:
    - name: {{ pkg }}
    - require_in:
      - file: iscsi_initiator_service_config
    {% endif %}
  {% endfor %}

  {% for pkg in iscsi.client.pkgs.wanted %}
    {% if pkg %}
iscsi_initiator_wanted_pkgs_{{ pkg }}:
  pkg.installed:
    - name: {{ pkg }}
    - hold: {{ iscsi.client.pkghold }}
    - reload: True
    - require_in:
      - file: iscsi_initiator_service_config
    {% endif %}
  {% endfor %}

{% if iscsi.client.make.wanted and salt['cmd.run']("id iscsi.user", output_loglevel='quiet') %}
  {% for pkg in iscsi.client.make.wanted %}
    {% if pkg %}
iscsi_initiator_make_pkg_{{ pkg }}:
  file.directory:
    - name: /home/{{ iscsi.user }}
    - makedirs: True
    - user: {{ iscsi.user }}
    - dir_mode: '0755'
      {% if iscsi.client.make.gitrepo %}
  git.latest:
    - name: {{ iscsi.client.make.gitrepo }}/{{ pkg }}.git
    - target: /home/{{ iscsi.user }}/{{ pkg }}
    - user: {{ iscsi.user }}
    - require:
      - file: iscsi_initiator_make_pkg_{{ pkg }}
      {% endif %}
  cmd.run:
    - cwd: /home/{{ iscsi.user }}/{{ pkg }}
    - name: {{ iscsi.client.make.cmd }}
    - runas: {{ iscsi.user }}
    {% endif %}
  {% endfor %}
{% endif %}

iscsi_initiator_service_config:
  file.managed:
    - name: {{ data.man5.config }}
    - source: {{ iscsi.cfgsource }}
    - template: jinja
    - user: root
    - group: {{ iscsi.group }}
    - mode: {{ iscsi.filemode }}
    - makedirs: True
    - context:
        data: {{ data|json }}
        component: 'initiator'
        provider: {{ provider }}
        json: {{ data['man5']['format']['json'] }}

{% if iscsi.kernel.mess_with_kernel and data.man5.kmodule and data.man5.kloadtext %}
iscsi_initiator_kernel_module:
  file.line:
    - name: {{ iscsi.kernel.modloadfile }}
    - content: {{ data.man5.kloadtext }}
    - backup: True
        {% if not iscsi.client.enabled %}
    - mode: delete
  cmd.run:
    - name: {{ iscsi.initiator.kernel.modunload }}
    - onlyif: {{ iscsi.initiator.kernel.modquery }}
        {% else %}
    - mode: ensure
    - after: autoboot_delay.*$
  cmd.run:
    - name: {{ iscsi.initiator.kernel.modload }}
    - unless: {{ iscsi.initiator.kernel.modquery }}
    - require:
      - file: iscsi_initiator_kernel_module
        {% endif %}
    - require_in:
      - service: iscsi_initiator_service
{% endif %}

iscsi_initiator_service:
  file.line:
    - onlyif: test "`uname`" = "FreeBSD"
    - name: {{ data.man5.svcloadfile }}
    - content: {{ data.man5.svcloadtext }}
    - backup: True
        {% if not iscsi.client.enabled %}
    - mode: delete
  service.disabled:
    - enable: False
        {% else %}
    - mode: ensure
    - after: ^salt.*$
  service.running:
    - enable: True
    - require:
      - file: iscsi_initiator_service_config
    - watch:
      - file: iscsi_initiator_service_config
        {% endif %}
    - name: {{ data.man5.svcname }}
{% if iscsi.kernel.mess_with_kernel and data.man5.kmodule %}
    - unless: {{ "%s %s".format(iscsi.kernel.modquery, data.man5.kmodule) }}
{% endif %}

