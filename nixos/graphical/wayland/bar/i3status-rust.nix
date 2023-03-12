{ pkgs
, config
, ...
}: {
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      icons = "material-nf";
      theme = "gruvbox-dark";
      blocks = [
        {
          block = "disk_space";
          path = "/";
          alias = "/";
          info_type = "available";
          unit = "GB";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        {
          block = "keyboard_layout";
          driver = "sway";
        }
        {
          block = "memory";
          interval = 1;
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "load";
          format = "{1m}";
          interval = 1;
        }
        {
          block = "sound";
          format = "{output_name} {volume}";
          # on_click = "pavucontrol --tab=3";
          mappings = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.iec958-stereo" = "";
          };
        }
        {
          block = "time";
          format = "%a %d/%m %R";
          interval = 60;
        }
      ];
    };
  };
}
