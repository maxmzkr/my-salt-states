natural-scrolling-block:
  file.blockreplace:
    - name: /usr/share/X11/xorg.conf.d/50-synaptics.conf
    - marker_start: "# START managed zone 1 -DO-NOT-EDIT-"
    - marker_end: "# END managed zone 1 -DO-NOT-EDIT-"
    - content: |
        Section "InputClass"
                Identifier "natural scrolling" 
                Driver "synaptics"
                MatchIsTouchpad "on"
                MatchDevicePath "/dev/input/event*"
                Option "VertScrollDelta" "-70"
                Option "HorizScrollDelta" "-70"
        EndSection
    - append_if_not_found: True
    - backup: '.bak'
    - show_changed: True

natural-scorlling-dconf:
  cmd.script:
    - name: scrolling-dconf
    - source: salt://natural-scrolling/script.sh
    - user: max
