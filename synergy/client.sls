synergy-client-script:
  file.managed:
    - name: /usr/bin/synergyc.sh
    - source: salt://synergy/synergy_client.sh
    - mode: 744
    - user: root
    - group: root

synergy-client-autostart:
  file.blockreplace:
    - name: /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
    - marker_start: "# START managed zone synergy-client-autostart -DO-NOT-EDIT"
    - marker_end: "# END managed zone synergy-client-autostart --"
    - append_if_not_found: True
    - content: greeter-setup-script=/usr/bin/synergyc.sh
    - backup: True
