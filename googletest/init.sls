googletest-extract:
  archive.extracted:
    - name: /tmp/googletest
    - source: https://googletest.googlecode.com/files/gtest-1.7.0.zip
    - source_hash: md5=2d6ec8ccdf5c46b05ba54a9fd1d130d7
    - archive_format: zip

googletest-configure:
  cmd.run:
    - name: /bin/bash ./configure
    - cwd: /tmp/googletest/gtest-1.7.0

googletest-make:
  cmd.run:
    - name: make
    - cwd: /tmp/googletest/gtest-1.7.0

googletest-install:
  cmd.run:
    - name: |
         sudo cp -a include/gtest /usr/include
         sudo cp -a lib/.libs/* /usr/lib/
    - cwd: /tmp/googletest/gtest-1.7.0
