{
  config,
  pkgs,
  ...
}: let
  inherit (config.xdg) cacheHome;
  lock-command = "swaylock --image ${cacheHome}/background_image -f";
in {
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
    events = [
      {
        event = "before-sleep";
        command = "${lock-command}";
      }
      {
        event = "lock";
        command = "${lock-command}";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${lock-command}";
      }
      {
        timeout = 600;
        command = ''hyprctl dpms off"'';
        resumeCommand = ''hyprctl dpms on"'';
      }
    ];
  };
}
