{
  description = "Derivations not ready for upstream";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    overlay = import ./overlay.nix;

  } // flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
  in {
    packages = import ./overlay.nix pkgs { inherit system; };
  });
}
