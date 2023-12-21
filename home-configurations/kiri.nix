{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home = {
    username = "kiri";
    stateVersion = "23.11";
    homeDirectory = if isDarwin then "/Users/kiri" else "/home/kiri/";
  };
}
