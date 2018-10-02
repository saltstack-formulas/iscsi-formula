======
iSCSI
======

Configure iSCSI targets and initiator on GNU/Linux and FreeBSD.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``iscsi``
----------
Meta-state to deploy iSNS and iSCSI solution.

``iscsi.isns``
---------------------
Configure the iSNS discovery service for iSCSI and iFCP.

``iscsi.target``
---------------------
Install and configure the iSCSI Target service. Supported vendor implementations include-

- ``/etc/ctl.conf`` for ``ctld(8)`` on FreeBSD 
- ``/etc/target/saveconfig.json` for ``LIOkernel target`` on GNU/Linux
- ``/etc/targets.conf`` for ``tgt(8)`` on GNU/Linux (largely obsolete)
- ``/etc/ietd.conf`` for `ietd(8)`` on GNU/Linux (largely obsolete)

``iscsi.initiator``
------------------
Install and configure the iSCSI initiator service. Supported vendor implementations include-

- ``/etc/iscsi.conf`` for FreeBSD
- ``/etc/iscsi/iscsid.conf`` or ``~/.iscsid.conf`` for ``open-iscsi`` on GNU/Linux

``iscsi.remove``
----------
Meta-state to remove iSNS and iSCSI solution.

``iscsi.isns.remove``
---------------------
Remove iSNS software (`open-isns`).

``iscsi.target.remove``
---------------------
Remove iSCSI target software (``ctld`` or ``tgt`` or ``ietd``).

``iscsi.initiator.remove``
--------------------------
Remove iSCSI initiator software (`iscsdi` or `open-iscsi`).

OS families
============
Works on FreeBSD, RedHat, Debian, Arch, and Suse os families. The ``iscis.target`` state for Linux (``LIO target``) requires the ``target_core_mod`` kernel module, which some vagrant, and all container images, lack.  

Archlinux
---------
AUR iscsi packages are supported. Run `users` state (users-formula) to create required ``iscsimake`` user (gid 0) on "Archlinux" before "iscsi-formula" states run. See example pillar data::

        iscsi:
        {% if grains.os == 'Arch' %}
          user: iscsimake

        users:
          iscsimake:
            sudouser: True
            shell: /bin/bash
            empty_password: True
            home: /home/iscsimake
            createhome: True
            optional_groups:
              - wheel
              - root
            sudo_rules:
             - 'ALL=(ALL) ALL'
        {% endif %}


Good Pillar data
=================
As with any daemon, bad iscsi conf(5)iguration causes issues. Bad pillar data results in daemon segfault, and problem with jinja 'max recursion exceeded' errors. Sanity check your pillar data to avoid unexpected failures

Potential useful future features
================================
- iscsi-plugin: https://github.com/projectatomic/iscsi-iscsi-plugin
- k8s-plugin: https://github.com/rootfs/kubernetes
- fcoe
- running in docker container


GNU/Linux sample pillar
========================
The state ``iscsi.target`` generates (``lio`` or ``tgt`` or ``ietd``) configuration, and the `iscsi.initiator` state generates (``open-iscsi``) configuration, for both FreeBSD and GNU/Linux.

Pillar-data::

           iscsi:
             isns:
               enabled: false
             target:
               lio:
                 myconf:
                   fabric-modules:
                     discovery_enable_auth: 'true'
                     discovery_mutual_password: "itsreallyme"
                     discovery_mutual_userid: "target"
                     discovery_password: "letmein"
                     discovery_userid: "initiator"
                     name: "iscsi"
                   storage-objects:
                     attributes:
                       block_size: 1024
                       emulate_write_cache: 0 
                       max_sectors: 1024
                       queue_depth: 128
                       task_timeout: 0 
                       unmap_granularity: 0 
                     dev: "/dev/vg_storage/station4mp"
                     name: "mptarget4"
                     plugin: "block"
                     wwn: "6be30fb6-3bc9-43c4-a866-4d8633af5cf2"
                   targets:
                     fabric: iscsi
                     tpgs:
                       attributes: 
                         authentication: 1
                         cache_dynamic_acls: 0
                         default_cmdsn_depth: 16
                         demo_mode_write_protect: 1
                         generate_node_acls: 0
                         login_timeout: 15
                         netif_timeout: 2
                         prod_mode_write_protect: 0
                       luns:
                         index: 0
                         storage_object: "/backstores/block/mptarget4"
                       node_acls:
                         attributes:
                           dataout_timeout: 3
                           dataout_timeout_retries: 5
                           default_erl: 0
                           nopin_response_timeout: 5
                           nopin_timeout: 5
                           random_datain_pdu_offsets: 0
                           random_datain_seq_offsets: 0
                           random_r2t_offsets: 0
                         chap_mutual_password: "itsreallyme"
                         chap_mutual_userid: "target"
                         chap_password: "letmein"
                         chap_userid: "station4"
                         mapped_luns:
                           index: 0
                           write_protect: 'false'
                           tpg_lun: 0
                         node_wwn: "iqn.1994-05.com.redhat:station4"
                         tcq_depth: 16
                       portals:
                         ip_address: "10.100.0.199"
                         port: 3260
                       tag: 1 
                     wwn: "iqn.2003-01.org.linux-iscsi.storage:mptarget4"
           

FreeBSD sample pillar
======================
The state ``iscsi.target`` generates ``/etc/ctl.conf`` for ``ctld(8)`` and enables the service.

Pillar-data::
      
        iscsi:
          target:
            ctld:
              myconf:
                isns-server:
                  - 'localhost'
                worstdevs:
                  auth-type: 'none'
                bestdevs:
                  chap-mutual:
                    - user = 'user'
                    - secret = 'secretsecret'
                    - mutual-user = "mutualuser"
                    - mutual-secret = "mutualsecret"
                  initiator-name:
                    - 'iqn.2012-06.com.example:initiatorhost1'
                    - 'iqn.2012-06.com.example:initiatorhost2'
                  initiator-portal:
                    - 192.168.1.1/16
                    - '[2001:db8::de:ef]'
              portal-group:
                cloud-west-zone0:
                  discovery-auth-group: no-authentication
                  listen:
                    - '0.0.0.0:3260'
                    - '[::]:3260'
                    - '[fe80::be:ef]:3261'
              lun:
                example0:
                  Alias: 0
                  path: /dev/zvol/tank/example_0
                  blocksize: 4096
                  size: 1G
                example1:
                  Alias: nice1
                  path: /dev/zvol/tank/example_1
                  option:
                    - 'naa 0x50015178f369f093'
                example2:
                  Alias: sillyexample2
                  backend: block
                  path: /dev/zvol/tank/example_0block_backends
                  device-type: 0
                  size: 5G
                  option:
                    vendor: myvendor
                    ha_role: primary
                    readcache: on
                    readonly: on
                    rpm: 0
                    umap: on
                    writecache: on
                    file: /dev/sd
                3:
                  Alias: myfile
                  path: /tmp/myfile
                  size: 1G
              target:
                'iqn.2008-04.com.example:target0':
                  Alias: bestdevs-cloudstore
                  auth-group: bestdevs
                  portal-group: cloud-west-zone0
                  lun:
                    - name = example0
                'naa.50015178f369f092':
                  port:
                    - isp0
                    - isp1
                  portal-group: cloud-west-zone0
                  lun:
                    - name = example1
                'iqn.2008-04.com.example:target1':
                  alias: lazydevs-cloudstore
                  auth-group: no-authentication
                  portal-group: cloud-west-zone0
                  lun:
                    - name = example2
                    - name = example3
                initiator:
                  iscsid:
                    myconf:
              node.startup: automatic
              'iqn.2018-07.com.example.iscsi:example01':
                targetAddress: '10.10.10.10'
              'naa.50015178f369f092':
                targetAddress: data1.example.com
                chapIName: user
                chapSecret: secretsecret
              'iqn.2018-07.com.example.iscsi:secretdata1':
                targetAddress: creditcards.example.com
                authMethod: CHAP
                chapIName: 'iqn.2018-07.com.example.iscsi:trustedguy'
                chapSecret: secretsecret

