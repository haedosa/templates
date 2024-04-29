{ pkgs }: with pkgs; let

  ghcid-bin = haskellPackages.ghcid.bin;

  mk-ghcid-command = { name, target}:
  runCommand name { buildInputs = [ makeWrapper ]; } ''
    makeWrapper "${ghcid-bin}/bin/ghcid" \
                $out/bin/${name} \
                --add-flags \
                "--command='cabal repl ${target}' \
                --test 'Main.main'"
  '';

  ghcid-exe = mk-ghcid-command { name = "ghcid-exe"; target = "exe:haedosa"; };

in haskellPackages.shellFor {
  withHoogle = true;
  packages = p: with p; [ haedosa-lib haedosa-app ];
  buildInputs =
    (with haskellPackages;
    # haskell tools
    [ haskell-language-server
      ghcid
    ]) ++

    # general tools
    [ cabal-install
      ghcid-exe
    ];
}
