{% from 'iscsi/default.jinja' import target_defaults %}

/etc/ctl.conf:
    file.managed:
      - source: salt://iscsi/files/ctl.conf
      - template: jinja
      - user: root
      - group: wheel
      - mode: 640

ctld:
    service.running:
      - enable: {{ salt['pillar.get']('iscsi-targets:enabled',
                        target_defaults.enabled) }}
      - require:
            - file: /etc/ctl.conf
      - watch:
            - file: /etc/ctl.conf
