{
  description = "Derivations not ready for upstream";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    overlays = {
      lmt = _: prev: { inherit (self.packages.${prev.stdenv.system}) lmt; };
      obsidian-export = _: prev: { inherit (self.packages.${prev.stdenv.system}) obsidian-export; };
      rancher-desktop = _: prev: { inherit (self.packages.${prev.stdenv.system}) rancher-desktop; };
      raycast = _: prev: { inherit (self.packages.${prev.stdenv.system}) raycast; };
      resilio-sync = _: prev: { inherit (self.packages.${prev.stdenv.system}) resilio-sync; };
    };

  } // flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
  in {
    packages = {
      lmt = pkgs.callPackage ./pkgs/lmt { };
      obsidian-export = pkgs.callPackage ./pkgs/obsidian-export { };
      rancher-desktop = pkgs.callPackage ./pkgs/rancher-desktop { };
      raycast = pkgs.callPackage ./pkgs/raycast { };
      resilio-sync = pkgs.callPackage ./pkgs/resilio-sync { };
    };
  });
}
