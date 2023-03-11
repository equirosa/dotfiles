{ pkgs
, config
, ...
}: {
  programs.i3status-rust = {
    enable = true;
    bars.top = {
      blocks = [
        {
          block = "disk_space";
          path = "/";
          unit = "GB";
          interval = 60;
          warning = 30.0;
          alert = 10.0;
        }
        {
          block = "keyboard_layout";
          driver = "sway";
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
