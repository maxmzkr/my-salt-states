haskell-preq-install:
  pkg.installed:
    - name: software-properties-common

haskell-repo:
  pkgrepo.managed:
    - ppa: hvr/ghc

cabal-install:
  pkg.installed:
    - name: cabal-install-1.20

haskell-install:
  pkg.installed:
    - name: ghc-7.8.4
