{ pkgs }:
let

  inherit (pkgs)
    mkShell
    mypython
    jupyterlab
  ;

in mkShell {
  buildInputs = [
    mypython
    jupyterlab
  ];
}
