{ lib, ... }:
let
  inherit (lib) fileContents;
in
{
  programs.wezterm = {
    enable = true;
    extraConfig = fileContents ./wezterm.lua;
  };
}
