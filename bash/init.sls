bash-fingerprint:
  ssh_known_hosts.present:
    - name: github.com
    - user: root
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

bash-clone:
  git.latest:
    - name: git@github.com:maxmzkr/.bash.git
    - target: /home/max/.bash
    - identity: /home/max/.ssh/github
    - submodules: True
    - user: max

bash-managed:
  file.blockreplace:
    - name: /home/max/.bashrc
    - marker_start: "# START managed zone 1 -DO-NOT-EDIT-"
    - marker_end: "# END managed zone 1 -DO-NOT-EDIT-"
    - content: |
        source /home/max/.bash/walk_this_folder.sh
    - append_if_not_found: True
    - backup: '.bak'
    - show_changed: True
