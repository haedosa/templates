final: prev: {

  haskell = let
    packageOverrides = prev.lib.composeManyExtensions [
      (prev.haskell.packageOverrides or (_: _: {}))
      (hfinal: hprev: {
        haedosa-lib = hfinal.callCabal2nix "haedosa-lib" ./haedosa-lib {};
        haedosa-app = hfinal.callCabal2nix "haedosa-app" ./haedosa-app {};
      })
  ];
  in prev.haskell // { inherit packageOverrides; };

}
