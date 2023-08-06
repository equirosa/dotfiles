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
      clock = true;
      daemonize = true;
      effect-blur = "7x5";
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
