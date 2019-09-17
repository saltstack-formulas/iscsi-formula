.. _readme:

iscsi-formula
================

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/iscsi-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/iscsi-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Configure iSCSI targets and initiator on GNU/Linux and FreeBSD.

Technology
----------
.. image:: docs/link-transport-storage-protocols.png
   :target: https://github.com/saltstack-formulas/iscsi-formula
   :scale: 25 %
   :alt: Link/Transport and Storage protocol infographic

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available states
----------------

.. contents::
   :local:

``iscsi``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

Deploy iSNS, iSCSI initiator, and iSCSI target
packages, manage configuration files and then
starts the associated iscsi services.

``iscsi.target``
---------------------
Install and configure the iSCSI Target service. Supported vendor implementations include-

- ``/etc/ctl.conf`` for ``ctld(8)`` on FreeBSD
- ``/etc/target/saveconfig.json` for ``LIO`` on GNU/Linux
- ``/etc/targets.conf`` for ``tgt(8)`` on GNU/Linux
- ``/etc/ietd.conf`` for `ietd(8)`` on GNU/Linux

The defaults targets are-

- ctld on FreeBSD
- LIO on CentOS, OpenSUSE, Arch
- tgt on Debian

The default choice is modifable via the `iscsi.target.provider` pillar value.
New providers can be introduced via pull request.

``iscsi.initiator``
------------------
Install and configure the iSCSI initiator service. Supported providers include:

- ``/etc/iscsi.conf`` for FreeBSD
- ``/etc/iscsi/iscsid.conf`` or ``~/.iscsid.conf`` for ``Open iSCSI`` on GNU/Linux

``iscsi.isns``
^^^^^^^^^^^^^^
Install and configure iSCSI name service.

``iscsi.target.package``
^^^^^^^^^^^^^^^^^^^^^^^^

Install iSCSI target packages.

``iscsi.target.config``
^^^^^^^^^^^^^^^^^^^^^^^

Customises iscsi target configuration. Requires ``iscsi.target.package`` via include list.

``iscsi.target.make``
^^^^^^^^^^^^^^^^^^^^^

This state makes iscsi target services on FreeBSD.

``iscsi.target.kernel``
^^^^^^^^^^^^^^^^^^^^^^^

Configures required kernel modules.

``iscsi.target.service``
^^^^^^^^^^^^^^^^^^^^^^^^

Start iscsi target services. Requires ``iscsi.target.config`` via include list.

``iscsi.target.clean``
^^^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``iscsi.target`` meta-state
 in reverse order, i.e.
stops the service,
removes the configuration files and
then uninstalls the package.

``iscsi.initiator.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Install iSCSI initiator packages.

``iscsi.initiator.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^

Customises iscsi initiator configuration. Requires ``iscsi.initiator.package`` via include list.

``iscsi.initiator.make``
^^^^^^^^^^^^^^^^^^^^^^^^

This state makes iscsi initiator services on FreeBSD.

``iscsi.initiator.kernel``
^^^^^^^^^^^^^^^^^^^^^^^^^^

Configures required kernel modules.

``iscsi.initiator.service``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Start iscsi initiator services. Requires ``iscsi.initiator.config`` via include list.

``iscsi.initiator.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``iscsi.initiator`` meta-state
 in reverse order, i.e.
stops the service,
removes the configuration files and
then uninstalls the package.

``iscsi.isns.package``
^^^^^^^^^^^^^^^^^^^^^^

Install iSCSI isns packages.

``iscsi.isns.config``
^^^^^^^^^^^^^^^^^^^^^

Customises iscsi isns configuration. Requires ``iscsi.isns.package`` via include list.

``iscsi.isns.make``
^^^^^^^^^^^^^^^^^^^

This state makes iscsi isns services on FreeBSD.

``iscsi.isns.kernel``
^^^^^^^^^^^^^^^^^^^^^

Configures required kernel modules.

``iscsi.isns.service``
^^^^^^^^^^^^^^^^^^^^^^

Start iscsi isns services. Requires ``iscsi.isns.config`` via include list.

``iscsi.isns.clean``
^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``iscsi.target`` meta-state
 in reverse order, i.e.
stops the service,
removes the configuration files and
then uninstalls the package.


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``iscsi`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

