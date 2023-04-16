{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
{
  gemini-browser = "${getExe pkgs.lagrange}";
  http-browser = "${getExe pkgs.firefox} -p default";
  terminal = {
    program = "${getExe pkgs.foot}";
    http-browser = "${getExe pkgs.w3m}";
    monitor = "${getExe pkgs.btop}";
    audio = "${getExe pkgs.pulsemixer}";
    file-manager = "${getExe pkgs.lf}";
    mail-client = "${getExe pkgs.aerc}";
    feed-reader = "${getExe pkgs.newsboat}";
  };
}
