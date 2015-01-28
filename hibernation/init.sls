hibernation_file:
  file.managed:
    - name: /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla
    - source:
      - salt://hibernation/hibernation.txt
