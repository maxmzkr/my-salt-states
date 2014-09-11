synergy-server-config:
  file.managed:
    - name: /etc/synergy.conf
    - source: salt://synergy/server_synergy.conf

synergy-server-autostart:
  file.blockreplace:
    - name: /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
    - marker_start: "# START managed zone synergy-server-autostart -DO-NOT-EDIT"
    - marker_end: "# END managed zone synergy-server-autostart --"
    - append_if_not_found: True
    - content: greeter-setup-script=/usr/bin/synergys -c /etc/synergy.conf
