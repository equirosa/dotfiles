_: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        output = ["DP-1" "HDMI-A-1"];
        modules-left = ["wlr/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = [
          "idle_inhibitor"
          "hyprland/language"
          "disk"
          "network"
          "memory"
          "cpu"
          "tray"
          "clock"
        ];
        clock = {format = "{:%Y-%m-%d | %H:%M}";};
        cpu = {format = "{load} - {usage}%  ";};
        disk = {format = "{free}/{total} 󰋊";};
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        memory = {format = "{}% 󰍛";};
        network = {
          format = "{ifname}";
          format-ethernet = "{bandwidthDownBits}  {ipaddr}/{cidr} ";
          format-disconnected = "󰣼";
        };
        "hyprland/language".format = "{}";
        "hyprland/window" = {
          "max-length" = 50;
          "all-outputs" = true;
          "offscreen-css" = true;
          "offscreen-css-text" = "(inactive)";
          "rewrite" = {
            "(.*) — Mozilla Firefox" = "  $1";
            "(.*) — fish" = " [$1]";
          };
        };
        "wlr/workspaces" = {
          format = "{name}: {icon}";
          on-click = "activate";
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
        tray = {spacing = 10;};
      };
    };
    systemd = {enable = true;};
  };
}
