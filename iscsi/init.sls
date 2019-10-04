# -*- coding: utf-8 -*-
# vim: ft=sls

include:
         {%- if grains.os_family in ('SArch',) %}
             {# This sequence avoids /etc/isns/isnsd.conf conflict on Arch #}
  - iscsi.initiator
  - iscsi.target
  - iscsi.isns
        {%- else %}
             {# This is the normal sequence #}
  - iscsi.isns
  - iscsi.initiator
  - iscsi.target
        {%- endif %}
