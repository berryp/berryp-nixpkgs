pkgs: super:

with pkgs;
{
  inherit (import ./pkgs/top-level { });
}
