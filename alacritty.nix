{ pkgs, stdenv, runtimeShell }:
stdenv.mkDerivation rec {
    name = "alacrittyc";

    src = ./.;

    buildInputs = [ pkgs.alacritty pkgs.makeWrapper ];

    binScript = ''
        #!${runtimeShell}
        ${pkgs.alacritty}/bin/alacritty --config-file ${placeholder "out"}/alacritty.toml
    '';

    passAsFile = [ "binScript" ];

    installPhase = ''
        mkdir -p $out/bin
        cp -r ./. $out/
        cp $binScriptPath $out/bin/alacrittyc
        chmod +x $out/bin/alacrittyc
    '';

}
