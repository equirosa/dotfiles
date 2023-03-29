{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
{
  http-browser = "${getExe pkgs. firefox} -p default";
  terminal-http-browser = "${getExe pkgs. w3m}";
}
