{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7103" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./persistent-try-bugs.nix { persistent-postgresql = nixpkgs.haskellPackages.persistent-postgresql; }
