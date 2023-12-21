{ pkgs
, ...
}:
let
  flatwrap = args: "flatpak ${args} --noninteractive --assumeyes";
in
{
  services.flatpak.enable = true;
  systemd.services.flatpak-update = {
    description = "Automatically update flatpaks";
    startAt = "*:0/4:00";
    serviceConfig.User = "kiri";
    path = [ pkgs.flatpak ];
    script = ''
      echo "Starting updates..."
      ${flatwrap "update"}
      ${flatwrap "uninstall --unused"}
      echo "Done!"
    '';
  };
}
