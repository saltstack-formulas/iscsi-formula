# -*- coding: utf-8 -*-
# vim: ft=sls

   {%- if grains.os not in ('Amazon', 'MacOS') %}
include:
  - .package
  - .make
  - .kernel
  - .config
  - .service
   {%- endif %}
