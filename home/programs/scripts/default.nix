{ pkgs, lib, ... }:
let
  inherit (lib) fileContents;
in
{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "regen";
      runtimeInputs = [ pkgs.nvd ];
      text = fileContents ./regen.sh;
    })
  ];
}
