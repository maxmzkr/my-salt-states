gcc-source-file:
  archive:
    - extracted
    - name: /usr/um/
    - source: https://www.dropbox.com/s/mjxtd3wl3xbulg4/gcc-4.7.0.tar.bz2?dl=1
    - source_hash: md5=12c59780094b6a39d0201b1bf464f612
    - archive_format: tar
    - tar_options: j
    - if_missing: /usr/um/gcc-4.7.0/
