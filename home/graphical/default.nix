{
  imports = [
    ./hyprland.nix
    ./notifications.nix
    ./screenlock.nix
    ./waybar
  ];
  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';
  services = {
    wlsunset = {
      enable = true;
      latitude = "-20.0";
      longitude = "-80.0";
    };
  };
}
