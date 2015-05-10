edge-scrolling-block:
  file.blockreplace:
    - name: /usr/share/X11/xorg.conf.d/50-synaptics.conf
    - marker_start: "# START managed zone 3 -DO-NOT-EDIT-"
    - marker_end: "# END managed zone 3 -DO-NOT-EDIT-"
    - content: |
        Section "InputClass"
                Identifier "no edge scrolling" 
                Driver "synaptics"
                MatchIsTouchpad "on"
                MatchDevicePath "/dev/input/event*"
                Option "HorizEdgeScroll" "0"
                Option "VertEdgeScroll" "0"
        EndSection
    - append_if_not_found: True
    - backup: '.bak'
    - show_changed: True
