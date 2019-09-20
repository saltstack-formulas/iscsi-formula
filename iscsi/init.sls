# -*- coding: utf-8 -*-
# vim: ft=sls

include:
         {%- if grains.os_family in ('Arch',) %}
             {# This sequence avoids /etc/isns/isnsd.conf conflict on Arch #}
  - iscsi.target
  - iscsi.initiator
  - iscsi.isns
        {%- else %}
             {# This is the normal sequence #}
  - iscsi.isns
  - iscsi.target
  - iscsi.initiator
        {%- endif %}
