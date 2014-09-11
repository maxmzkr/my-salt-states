synergy-client-autostart:
  file.blockreplace:
    - name: /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
    - marker_start: "# START managed zone synergy-client-autostart -DO-NOT-EDIT"
    - marker_end: "# END managed zone synergy-client-autostart --"
    - append_if_not_found: True
    - content: greeter-setup-script=/usr/bin/synergys --crypto-pass '{{ salt["PasswordGetter.get_password"]("synergy") }}' 10.0.0.9
