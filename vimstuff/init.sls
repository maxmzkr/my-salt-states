vimstuff-fingerprint:
  ssh_known_hosts.present:
    - name: github.com
    - user: root
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

vimstuff-clone:
  git.latest:
    - name: git@github.com:maxmzkr/vimstuff.git
    - target: /home/max/.vimstuff
    - identity: /home/max/.ssh/github
    - user: max

vimstuf-vimrc-link:
  file.symlink:
    - name: /home/max/.vimrc
    - target: /home/max/.vimstuff/.vimrc
    - user: max

vimstuff-vim-link:
  file.symlink:
    - name: /home/max/.vim
    - target: /home/max/.vimstuff/.vim
    - user: max
