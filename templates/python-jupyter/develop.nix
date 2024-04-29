{ pkgs }:
let

  inherit (pkgs)
    mkShell
    mypython
  ;

in mkShell {
  buildInputs = [
    mypython
  ];
}
