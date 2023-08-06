{ pkgs, lib, ... }:
let
  dpms = "hyprctl dispatch dpms";
  lock-command = "${lib.getBin pkgs.swaylock-effects}";
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      show-keyboard-layout = true;
      daemonize = true;
      effect-blur = "7x5";
      clock = true;
      image = "~/Pictures/desktop_backgrounds/gifs/city.gif";
      indicator = true;
      font-size = 25;
      indicator-radius = 85;
      indicator-thickness = 16;
      fade-in = 0.2;
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
