/*
  This is a file with replacements I want to have that won't be expanded by fish
*/
{ pkgs
, lib
, ...
}:
let
  inherit (lib) getExe;
in
{
  cat = "${getExe pkgs.bat} --plain";
  ls = getExe pkgs.lsd;
}
