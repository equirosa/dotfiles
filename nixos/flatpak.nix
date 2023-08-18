{ pkgs
, ...
}: {
  services.flatpak.enable = true;
  systemd = {
    services.flatpak-update =
      let
        flatpak-wrap = args: "${pkgs.flatpak}/bin/flatpak ${args} --noninteractive --assumeyes";
      in
      {
        description = "Automatically update flatpaks";
        startAt = "*:0/4:00";
        serviceConfig.User = "kiri";
        script = ''
          echo "Starting updates..."
          ${flatpak-wrap "update"}
          ${flatpak-wrap "uninstall --unused"}
          echo "Done!"
        '';
      };
  };
}
