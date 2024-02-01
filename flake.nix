{
    description = "Flake for fully configured alacritty";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils, ... }: {
        overlays.default = final: prev: {
            alacrittyc = final.callPackage ./alacritty.nix {};
        };
    } // flake-utils.lib.eachDefaultSystem (system:
	let 
        pkgs = import nixpkgs {
            inherit system;
            overlays = [
                self.overlays.default
            ];
        };

	in {
        packages.default = pkgs.alacrittyc;

		devShell = pkgs.mkShell {
			packages = (with pkgs; [
				alacrittyc
			]);
		};
	});
}
