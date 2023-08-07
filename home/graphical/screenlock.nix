{ pkgs, lib, ... }:
let
  inherit (pkgs) hyprland swaylock-effects;
  dpms = "${hyprland}/bin/hyprctl dispatch dpms";
  lock-command = "${lib.getExe swaylock-effects}";
in
{
  programs.swaylock = {
    enable = true;
    package = swaylock-effects;
    settings = {
      clock = true;
      daemonize = true;
      effect-vignette = "0.5:0.5";
      fade-in = 0.2;
      font-size = 25;
      image = "~/Pictures/desktop_backgrounds/gifs/city.gif";
      indicator = true;
      indicator-radius = 85;
      indicator-thickness = 16;
      show-keyboard-layout = true;
    };
  };
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    events = [
      {
        event = "before-sleep";
        command = lock-command;
      }
      {
        event = "lock";
        command = lock-command;
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = lock-command;
      }
      {
        timeout = 600;
        command = "${dpms} off";
        resumeCommand = "${dpms} on";
      }
    ];
  };
}
