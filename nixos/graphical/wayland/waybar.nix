_: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        output = [ "DP-1" "HDMI-A-1" ];
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "idle_inhibitor"
          "sway/language"
          "disk"
          "network"
          "memory"
          "keyboard-state"
          "cpu"
          "tray"
          "clock"
        ];
        clock = { format = "{:%Y-%m-%d | %H:%M}"; };
        cpu = { format = "{load} - {usage}%  "; };
        disk = { format = "{free}/{total}"; };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
        memory = { format = "{}% "; };
        network = {
          format = "{ifname}";
          format-ethernet = "{bandwidthDownBits}⬇️  {ipaddr}/{cidr} ";
          format-disconnected = "disconnected";
        };
        "sway/language".format = "{flag}";
        "sway/window" = {
          "format" = "{title}";
          "max-length" = 50;
          "all-outputs" = true;
          "offscreen-css" = true;
          "offscreen-css-text" = "(inactive)";
          "rewrite" = {
            "(.*) — Mozilla Firefox" = "🌎  $1";
            "(.*) — fish" = " [$1]";
          };
        };
        "sway/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "6" = "";
            "8" = "";
            "9" = "";
            "default" = "";
            "focused" = "";
            "urgent" = "";
          };
        };
        tray = { spacing = 10; };
      };
    };
    systemd = { enable = true; };
  };
}
