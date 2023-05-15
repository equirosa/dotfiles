{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
{
  gemini-browser = getExe pkgs.lagrange;
  http-browser = "${getExe pkgs.firefox} -p default";
  image-viewer = getExe pkgs.imv;
  notify = "${getExe pkgs.libnotify} -t 5000";
  terminal = getExe pkgs.foot;
  terminal-audio = getExe pkgs.pulsemixer;
  terminal-feed-reader = getExe pkgs.newsboat;
  terminal-file-manager = getExe pkgs.lf;
  terminal-http-browser = getExe pkgs.w3m;
  terminal-mail-client = getExe pkgs.aerc;
  terminal-monitor = getExe pkgs.btop;
}
