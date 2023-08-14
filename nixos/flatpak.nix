{ pkgs
, lib
, ...
}: {
  services.flatpak.enable = true;
  systemd = {
    services.flatpak-update = {
      description = "Automatically update flatpaks";
      startAt = "*:0/4:00";
      serviceConfig.User = "kiri";
      script = pkgs.writeShellApplication {
        name = "flatpak-update-script";
        runtimeInputs = [ pkgs.flatpak ];
        text = ''
          echo "Starting updates..."
          flatpak update --noninteractive --assumeyes
          flatpak uninstall --unused --noninteractive --assumeyes
          echo "Done!"
        '';
      };
    };
  };
}
