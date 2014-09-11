base:
  '*':
    - eecs281
    - synergy
  'nodename:MAX-COMPY':
    - match: grain
    - synergy.server
  'nodename:(MAX-TAPPY|MAX-LAPPY)':
    - match: grain_pcre
    - synergy.client
