{

  inputs = {

    haedosa.url = "github:haedosa/flakes";
    nixpkgs.follows = "haedosa/nixpkgs";

  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.self.overlays.default ];
      };
    in {

      inherit pkgs;

      overlays = {
        default = import ./overlay.nix;
      };

      packages.${system} = {
        default = pkgs.haskellPackages.haedosa-app;
        haedosa-lib = pkgs.haskellPackages.haedosa-lib;
        haedosa-app = pkgs.haskellPackages.haedosa-app;
      };

      apps.${system} = {
        default = {
          type = "app";
          program = "${pkgs.haskellPackages.haedosa-app}/bin/haedosa-app";
        };
      };

      devShells.${system} = {
        default = pkgs.callPackage ./develop.nix {};
      };

    };

}
