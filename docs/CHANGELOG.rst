.. role:: raw=html=m2r(raw)
   :format: html


Changelog
---------

1.0.0 (2019-10-04)
------------------

Bug Fixes
^^^^^^^^^


* **arch:** harden jinja for archlinux (\ `4ec440c <https://github.com/saltstack-formulas/iscsi-formula/commit/4ec440c>`_\ )
* **archlinux:** update osfamilymap (\ `ea82c99 <https://github.com/saltstack-formulas/iscsi-formula/commit/ea82c99>`_\ )
* **clean:** fix clean kernel state (\ `a31079c <https://github.com/saltstack-formulas/iscsi-formula/commit/a31079c>`_\ )
* **clean:** fix clean states (\ `f4224fc <https://github.com/saltstack-formulas/iscsi-formula/commit/f4224fc>`_\ )
* **config:** only generate custom config if pillar data supplied (\ `8664023 <https://github.com/saltstack-formulas/iscsi-formula/commit/8664023>`_\ )
* **defaults:** fix username on archlinux (\ `6dfa8a1 <https://github.com/saltstack-formulas/iscsi-formula/commit/6dfa8a1>`_\ )
* **freebsd:** loader.conf is existing file (\ `d4d176f <https://github.com/saltstack-formulas/iscsi-formula/commit/d4d176f>`_\ )
* **freebsd:** required changes for freebsd 11.2 (\ `1ef79ec <https://github.com/saltstack-formulas/iscsi-formula/commit/1ef79ec>`_\ )
* **isns:** fix jinja in config file template (\ `8dfc993 <https://github.com/saltstack-formulas/iscsi-formula/commit/8dfc993>`_\ )
* **jinja:** fix error while parsing a flow (\ `8d9d959 <https://github.com/saltstack-formulas/iscsi-formula/commit/8d9d959>`_\ )
* **jinja:** fixes for file management (\ `2575062 <https://github.com/saltstack-formulas/iscsi-formula/commit/2575062>`_\ )
* **kernel:** fix kernel module states (\ `0fca2fa <https://github.com/saltstack-formulas/iscsi-formula/commit/0fca2fa>`_\ )
* **kernelmod:** refactor kernel states (\ `9aac15a <https://github.com/saltstack-formulas/iscsi-formula/commit/9aac15a>`_\ )
* **os:** better os mapping (\ `55e4cfb <https://github.com/saltstack-formulas/iscsi-formula/commit/55e4cfb>`_\ )
* **os:** fix open-iscsi on archlinux (\ `43b2ad4 <https://github.com/saltstack-formulas/iscsi-formula/commit/43b2ad4>`_\ )
* **saltbug:** file.line is buggy; use file.prepend (\ `f72fe9e <https://github.com/saltstack-formulas/iscsi-formula/commit/f72fe9e>`_\ )
* **saltbug:** fix for strange 'unless: :raw-html-m2r:`<url>`\ ' bug (\ `5de113d <https://github.com/saltstack-formulas/iscsi-formula/commit/5de113d>`_\ )
* **service:** only start service if enabled (\ `b8d8b7f <https://github.com/saltstack-formulas/iscsi-formula/commit/b8d8b7f>`_\ )
* **suse:** service is called targetcli on Suse15 (\ `4f37896 <https://github.com/saltstack-formulas/iscsi-formula/commit/4f37896>`_\ )
* **target:** increase volsize and minor fixes (\ `9c50ef9 <https://github.com/saltstack-formulas/iscsi-formula/commit/9c50ef9>`_\ )
* **target:** some minor fixes (\ `ab04191 <https://github.com/saltstack-formulas/iscsi-formula/commit/ab04191>`_\ )
* **template:** comments not supported by json standard (\ `433d647 <https://github.com/saltstack-formulas/iscsi-formula/commit/433d647>`_\ )
* **tgt:** fix for tgtadm: invalid request (\ `de4b9f0 <https://github.com/saltstack-formulas/iscsi-formula/commit/de4b9f0>`_\ )
* **travis:** travis wants loop4-7 (\ `7671bec <https://github.com/saltstack-formulas/iscsi-formula/commit/7671bec>`_\ )
* **ubuntu:** fix target service name on ubuntu (\ `36c63a7 <https://github.com/saltstack-formulas/iscsi-formula/commit/36c63a7>`_\ )
* **ubuntu:** update list of default packages (\ `bf99361 <https://github.com/saltstack-formulas/iscsi-formula/commit/bf99361>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **formula:** align to template-formula & fix `#19 <https://github.com/saltstack-formulas/iscsi-formula/issues/19>`_ (\ `dfb5b27 <https://github.com/saltstack-formulas/iscsi-formula/commit/dfb5b27>`_\ )
* **osmaps:** add osfinger, osmap (\ `add55e0 <https://github.com/saltstack-formulas/iscsi-formula/commit/add55e0>`_\ )

Documentation
^^^^^^^^^^^^^


* **archlinux:** add user to pillar.example (\ `4b09216 <https://github.com/saltstack-formulas/iscsi-formula/commit/4b09216>`_\ )
* **example:** update pillars for travis (\ `ffc2ddd <https://github.com/saltstack-formulas/iscsi-formula/commit/ffc2ddd>`_\ )
* **lint:** fix lint errors & skip service on centos/travis (\ `1a6161f <https://github.com/saltstack-formulas/iscsi-formula/commit/1a6161f>`_\ )
* **readme:** list all states (\ `930fb9e <https://github.com/saltstack-formulas/iscsi-formula/commit/930fb9e>`_\ )
* **readme:** update description (\ `02cad31 <https://github.com/saltstack-formulas/iscsi-formula/commit/02cad31>`_\ )
* **readme:** update documentation re. targets (\ `c90f86d <https://github.com/saltstack-formulas/iscsi-formula/commit/c90f86d>`_\ )
* **suse:** update pillar example packages (\ `ff54b33 <https://github.com/saltstack-formulas/iscsi-formula/commit/ff54b33>`_\ )
* **unused:** removing depreciated docs/ files (\ `118a2d6 <https://github.com/saltstack-formulas/iscsi-formula/commit/118a2d6>`_\ )

Features
^^^^^^^^


* **kernel:** advice re kernel upgrades (\ `77d3625 <https://github.com/saltstack-formulas/iscsi-formula/commit/77d3625>`_\ )

Tests
^^^^^


* **arch/cent:** updated kitchen tests (\ `d519be1 <https://github.com/saltstack-formulas/iscsi-formula/commit/d519be1>`_\ )
* **lint:** fix yamllint errors (\ `2ab2b3e <https://github.com/saltstack-formulas/iscsi-formula/commit/2ab2b3e>`_\ )
* **matrix:** choose appropriate os (\ `42d9f7a <https://github.com/saltstack-formulas/iscsi-formula/commit/42d9f7a>`_\ )
* **travis:** add dependency to lvm; update pillar data (\ `fb694a0 <https://github.com/saltstack-formulas/iscsi-formula/commit/fb694a0>`_\ )
* **travis:** add travis yml (\ `828f827 <https://github.com/saltstack-formulas/iscsi-formula/commit/828f827>`_\ )
* **travis:** change loop0-3 to loop4-7 (\ `17d3833 <https://github.com/saltstack-formulas/iscsi-formula/commit/17d3833>`_\ )
* **travis:** fix centos7 kernel (\ `b562cb0 <https://github.com/saltstack-formulas/iscsi-formula/commit/b562cb0>`_\ )
* **travis:** fixup yamllint (\ `9690093 <https://github.com/saltstack-formulas/iscsi-formula/commit/9690093>`_\ )
* **travis:** no iscsi target package for amazonlinux (\ `d2f2b4e <https://github.com/saltstack-formulas/iscsi-formula/commit/d2f2b4e>`_\ )
* **travis:** workaround travis nuances (\ `61502c9 <https://github.com/saltstack-formulas/iscsi-formula/commit/61502c9>`_\ )
