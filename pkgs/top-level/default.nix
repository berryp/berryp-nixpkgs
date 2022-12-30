{ pkgs ? import <nixpkgs> { } }:

with pkgs;
{
  lg-osc = pkgs.callPackage ./../lg-osc { };
  lmt = pkgs.callPackage ./../lmt { };
  obsidian-export = pkgs.callPackage ./../obsidian-export { };
  rancher-desktop = pkgs.callPackage ./../rancher-desktop { };
  raycast = pkgs.callPackage ./../raycast { };
  resilio-sync = pkgs.callPackage ./../resilio-sync { };
}
