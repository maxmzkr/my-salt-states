bin-fingerprint:
  ssh_known_hosts.present:
    - name: github.com
    - user: root
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

bin-clone:
  git.latest:
    - name: git@github.com:maxmzkr/.bin.git
    - target: /home/max/.bin
    - identity: /home/max/.ssh/github
    - submodules: True
    - user: max
