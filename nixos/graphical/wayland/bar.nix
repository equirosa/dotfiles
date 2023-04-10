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
          info_type = "available";
          alert_unit = "GB";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        { block = "net"; }
        {
          block = "keyboard_layout";
          driver = "sway";
          mappings = {
            "English (US)" = "🇺🇸";
            "Spanish (Latin American)" = "🇨🇷";
          };
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
          format = " $icon $1m.eng(w:4) ";
          interval = 1;
        }
        {
          block = "sound";
          format = " $icon $output_name{ $volume|} ";
          # on_click = "pavucontrol --tab=3";
          mappings = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "💻";
            "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.iec958-stereo" = "🎧";
          };
        }
        {
          block = "time";
          format = {
            full = " $icon $timestamp.datetime(f:'%a %Y-%m-%d %R') ";
            short = " $icon $timestamp.datetime(f:%R) ";
          };
          interval = 60;
        }
      ];
    };
  };
}
