{ mkDerivation, base, persistent, persistent-postgresql, stdenv, persistent-template, persistent-sqlite }:
mkDerivation {
  pname = "persistent-try-bugs";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base persistent persistent-postgresql persistent-template
    persistent-sqlite
  ];
  description = "Skeleton project";
  license = stdenv.lib.licenses.unfree;
}
