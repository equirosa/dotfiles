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
      runtimeInputs = attrValues { inherit (pkgs) nvd; };
      text = fileContents ./regen.sh;
    })
  ];
}
