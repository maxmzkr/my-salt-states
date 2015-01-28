trash-cli
  pkg.installed:
    - name: trash-cli

trash-rm-file:
  file.managed:
    - name: /home/max/.bin/trash-rm
    - source:
      - salt://trash/trash.txt


