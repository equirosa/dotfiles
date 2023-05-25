{config,...}:
let
inherit (config.xdg) cacheHome;
lock-command = "swaylock --image ${cacheHome}/background_image -f";
in
{
  programs.swaylock = {
  enable=true;
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
             resumeCommand= ''hyprctl dpms on"'';
          }
        ];
      };
}
