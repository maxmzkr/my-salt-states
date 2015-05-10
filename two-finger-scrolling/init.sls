two-finger-scrolling-block:
  file.blockreplace:
    - name: /usr/share/X11/xorg.conf.d/50-synaptics.conf
    - marker_start: "# START managed zone 2 -DO-NOT-EDIT-"
    - marker_end: "# END managed zone 2 -DO-NOT-EDIT-"
    - content: |
        Section "InputClass"
                Identifier "two finger scrolling" 
                Driver "synaptics"
                MatchIsTouchpad "on"
                MatchDevicePath "/dev/input/event*"
                Option "HorizTwoFingerScroll" "1"
        EndSection
    - append_if_not_found: True
    - backup: '.bak'
    - show_changed: True
