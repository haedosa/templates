{

  inputs = {

    haedosa.url = "github:haedosa/flakes";
    nixpkgs.follows = "haedosa/nixpkgs";
    jupyter-overlay = {
      url = "github:haedosa/jupyter-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          inputs.self.overlays.default
          inputs.jupyter-overlay.overlay
        ];
      };
    in {

      inherit pkgs;

      overlays = {
        default = import ./overlay.nix;
      };

      packages.${system} = {
        default = pkgs.jupyterlab;
      };

      apps.${system} = {
        default = {
          type = "app";
          program = "${pkgs.jupyterlab}/bin/jupyter-lab";
        };
      };

      devShells.${system} = {
        default = pkgs.callPackage ./develop.nix {};
      };

    };

}
