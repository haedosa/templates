{

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs:
  let
    inherit (inputs.nixpkgs.lib) genAttrs;
    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = genAttrs supportedSystems;
    pkgsFor = nixpkgs_: system: import nixpkgs_ { inherit system; config = { allowUnfree = true; }; };
  in
  {

    pkgs = forAllSystems (system: pkgsFor inputs.nixpkgs system);

    templates = {

      haskell = {
        path = ./templates/haskell;
        description = "Haskell Project Template";
      };

      python = {
        path = ./templates/python;
        description = "Python Project Template";
      };

    };

  };

}
