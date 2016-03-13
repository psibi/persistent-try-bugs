# persistent-try-bugs

Personal repository used with nix for fixing bugs related to persistent

## Sqlite refresher

sqlite3 db_name

Some commands:

* .tables
* .schema <table_name>
* .quit

## Postgresql refresher (psql)

sudo su

su postgres

psql -U postgres

Some commands:

* \l   (List of databases)
* \d   (List of tables)
* \c db_name (Connect to database named db_name)
* \du  (List users)


Note:

* While developing with nix, make sure you override the package as mentioned [in the manual](https://nixos.org/nixpkgs/manual/#how-to-build-projects-that-depend-on-each-other).
* If you are running this command `nix-build "<nixpkgs>" -A haskellPackages.persistent-postgresql`, then make sure you don't run it in the source directory of it. It fails of permission error when I do that. Haven't yet figured out why this happens.
* Make sure to run `cabal configure` after building the private package on your project which depends on that private package. Directly running `cabal build` won't take the new library.
