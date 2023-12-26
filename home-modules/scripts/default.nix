{ pkgs, lib, ... }:
let
  inherit (pkgs) writeShellApplication;
  inherit (lib)
    attrValues
    fileContents
    ;
in
{
  home.packages = [
    (writeShellApplication {
      name = "regen";
      runtimeInputs = attrValues { inherit (pkgs) libnotify nvd; };
      text = fileContents ./regen.sh;
    })
    (writeShellApplication {
      name = "show-nix-store-path";
      text = ''realpath "$(command -v "''${1}")"'';
    })
    (writeShellApplication {
      name = "show-script";
      runtimeInputs = attrValues { inherit (pkgs) bat; };
      text = ''bat -p "$(show-nix-store-path "''${1}")"'';
    })
  ];
}
