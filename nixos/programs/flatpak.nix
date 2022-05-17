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
        after = ["network-online.target"];
        description = "Automatically Update Flatpaks";
        documentation = ["man:flatpak(1)"];
        wants = ["network-online.target"];
        wantedBy = ["multi-user.target"];
        path = with pkgs; [bash flatpak];
        serviceConfig = {
          ExecStart = ''flatpak --user update --assumeyes'';
          Type = "oneshot";
        };
      };
    };
    timers = {
      flatpak-upgrade-timer = {
        after = ["nixos-upgrade.service"];
        description = "Update flatpaks at mid-day";
        requiredBy = ["timers.target"];
        timerConfig = {
          OnCalendar = "12:0:0";
          Unit = "flatpak-upgrade.service";
          Persistent = true;
        };
        wantedBy = ["timers.target"];
      };
    };
  };
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-gtk];
}
