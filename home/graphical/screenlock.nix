{ pkgs, lib, ... }:
let
  lock-command = "${lib.getBin pkgs.swaylock-effects}";
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      show-keyboard-layout = true;
      daemonize = true;
      effect-blur = "15x2";
      clock = true;
      indicator = true;
      font-size = 25;
      indicator-radius = 85;
      indicator-thickness = 16;
      screenshots = true;
      fade-in = 1;
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
    timeouts = let dpms = "hyprctl dispatch dpms"; in [
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
