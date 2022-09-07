{pkgs, ...}: {
  home-manager.users.kiri.programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        output = [
          "DP-1"
          "HDMI-A-1"
        ];
        modules-left = ["sway/workspaces" "sway/mode"];
        modules-center = ["sway/window"];
        modules-right = ["idle_inhibitor" "sway/language" "disk" "network" "memory" "keyboard-state" "cpu" "tray" "clock"];
        clock = {format = "{:%Y-%m-%d | %H:%M}";};
        "cpu" = {format = "{load} - {usage}%  ";};
        disk = {format = "{free}/{total}";};
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
        memory = {format = "{}% ";};
        network = {
          format = "{ifname}";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-disconnected = "disconnected";
        };
        "sway/workspaces" = {
          "format" = "{name}: {icon}";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "5" = "";
            "8" = "";
            "9" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };
        "tray" = {spacing = 10;};
      };
    };
    systemd = {enable = true;};
  };
}
