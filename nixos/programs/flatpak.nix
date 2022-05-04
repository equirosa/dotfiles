{
  config,
  pkgs,
  ...
}: {
  services = {
    flatpak.enable = true;
  };
  systemd.user = {
    services = {
      flatpak-upgrade = {
        description = "Automatically Update Flatpaks";
        documentation = ["man:flatpak(1)"];
        wantedBy = ["default.target"];
        path = with pkgs; [bash flatpak];
        serviceConfig = {
          ExecStart = ''flatpak update --assumeyes'';
        };
      };
    };
    timers = {
      flatpak-upgrade-timer = {
        after = ["nixos-upgrade.service"];
        description = "Flatpak Update Timer";
        requiredBy = ["timers.target"];
        timerConfig = {
          OnCalendar = "12:0:0";
          Unit = "flatpak-upgrade.service";
        };
      };
    };
  };
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-gtk];
}
