haskell-repo:
  pkgrepo.managed:
    - ppa: hvr/ghc

haskell-cabal-install:
  pkg.installed:
    - name: cabal-install-1.20
    - reload_modules: true

haskell-ghc-install:
  pkg.installed:
    - name: ghc-7.8.4

cabal-update:
  cmd.run:
    - name: cabal-1.20 update
    - user: max

cabal-install-alex:
  cmd.run:
    - name: cabal-1.20 install alex
    - user: max

cabal-install-happy:
  cmd.run:
    - name: cabal-1.20 install happy
    - user: max
