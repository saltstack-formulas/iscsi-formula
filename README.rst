iSCSI-Formula for SaltStack
===========================

Configure iSCSI targets and initiator on FreeBSD 10.

iscsi.target
-------------
The state ``iscsi.target`` generates ``/etc/ctl.conf``
for ``ctld(8)`` and enables the service.

Pillar-data::

    iscsi-target:
        enabled: True
        pidfile: /var/run/cltd.pid # I guess?
        auth-groups:
            a-g-name: 
                chaps:
                    user: secret
            ...
        portal-groups:
            pg-name:
                listen: address
                discovery-auth-group: name
            ...
        targets:
            # I think you have to quote the IQN or 
            # YAML will have a fit b/c of the colon
            'iqn.2008-04.com.example:target0':
                auth-group: name
                portal-group: name
                luns:
                    0: 
                        path: /path/to
                        size: 5G
                    1: path
                    ...
            ...


iscsi.initiator
---------------
The state ``iscsi.initiator`` states configures the iSCSI
initiator and enables the service ``iscsid(8)``.

Pillar-structure::

    iscsi-initiator:
        auto_connect: True
        targets:
            t0:
                TargetAddress: 10.10.10.10
                TargetName: iqn.2012-06.com.example:target0
                AuthMethod: CHAP
                chapIName: user
                chapSecret: secretsecret
            ...


iscsi.remove
------------
The state ``iscsi.remove`` disables the services and
removes the packages of both initiator and target.

No pillar data is needed.
