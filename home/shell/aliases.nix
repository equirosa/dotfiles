# This is a file with replacements I want to have that won't be expanded by fish
{ pkgs
, ...
}:
{
  cat = "${pkgs.bat}/bin/bat --plain";
  ls = "${pkgs.lsd}/bin/lsd";
}
