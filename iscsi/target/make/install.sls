# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_install = tplroot ~ '.target.service.install' %}
{%- from tplroot ~ "/map.jinja" import iscsi with context %}

  {%- if iscsi.target.make.wanted %}
      {%- if salt['cmd.run']("id iscsi.user", output_loglevel='quiet') %}
include:
  - {{ sls_service_install }}

iscsi-target-make-file-directory:
  file.directory:
    - name: /home/{{ iscsi.user }}
    - makedirs: True
    - user: {{ iscsi.user }}
    - dir_mode: '0755'

          {%- for pkg in iscsi.target.make.wanted %}

iscsi-target-make-{{ pkg }}-git-latest:
  git.latest:
    - onlyif: {{ iscsi.target.make.gitrepo }}
    - name: {{ iscsi.target.make.gitrepo }}/{{ pkg }}.git
    - target: /home/{{ iscsi.user }}/{{ pkg }}
    - user: {{ iscsi.user }}
    - force_clone: True
    - force_fetch: True
    - force_reset: True
    - force_checkout: True
              {% if grains['saltversioninfo'] >= [2017, 7, 0] %}
    - retry:
        attempts: 3
        until: True
        interval: 60
        splay: 10
              {%- endif %}
    - require:
      - file: iscsi-target-make-file-directory

iscsi-target-make-{{ pkg }}-cmd-run:
  cmd.run:
    - cwd: /home/{{ iscsi.user }}/{{ pkg }}
    - name: {{ iscsi.target.make.cmd }}
    - runas: {{ iscsi.user }}
    - require:
      - git: iscsi-target-make-{{ pkg }}-git-latest
    - require_in:
      - sls: {{ sls_service_install }}

          {% endfor %}
      {%- endif %}
  {%- endif %}
