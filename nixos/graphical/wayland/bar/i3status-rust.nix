{ pkgs , config , ... }: {
  home-manager.users.kiri.programs.i3status-rust = {
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
      ];
    };
  };
}
