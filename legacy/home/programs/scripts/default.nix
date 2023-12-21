{ pkgs, lib, ... }:
let
  inherit (lib) fileContents;
  inherit (import ../../shell/aliases.nix { inherit pkgs lib; }) cat;
in
{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "regen";
      runtimeInputs = [ pkgs.nvd ];
      text = fileContents ./regen.sh;
    })
    (writeShellApplication {
      name = "show-nix-store-path";
      text = ''realpath "$(command -v "''${1}")"'';
    })
    (writeShellApplication {
      name = "show-script";
      text = ''${cat} "$(show-nix-store-path "''${1}")"'';
    })
  ];
}
