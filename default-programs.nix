{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe;
  inherit (config.home-manager.users.kiri.xdg) cacheHome;
in {
  gemini-browser = getExe pkgs.lagrange;
  http-browser = "${getExe pkgs.firefox} -p default";
  lock-command = "${getExe pkgs.swaylock} --image ${cacheHome}/background_image -f";
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
