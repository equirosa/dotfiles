{ pkgs, lib, ... }:
let
  inherit (lib) fileContents;
in
{
  programs.wezterm = {
    enable = pkgs.stdenv.isLinux;
    extraConfig = fileContents ./wezterm.lua;
  };
}
