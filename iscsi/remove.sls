##
# Initiator(s)

iscsid:
  service.dead:
    - enable: False
    - sig: iscsid

/etc/iscsi.conf:
  file.absent:
    - require:
      - service: iscsid


##
# Target(s)

ctld:
  service.dead:
    - enable: False
    - sig: ctld

/etc/ctl.conf:
  file.absent:
    - require:
      - service: ctld
