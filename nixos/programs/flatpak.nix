{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) attrValues getExe;
in
{
  services = {
    flatpak.enable = true;
  };
  systemd = {
    services.update-flatpak = {
      serviceConfig = {
        Type = "oneshot";
        User = "kiri";
        path = attrValues { inherit (pkgs) flatpak; };
        script = ''
          flatpak update --assumeyes
        '';
      };
    };
    timers = {
      flatpak-upgrade-timer = {
        after = [ "nixos-upgrade.service" ];
        description = "Update flatpaks at mid-day";
        requiredBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "0/6:0:0";
          Unit = "update-flatpak.service";
          Persistent = true;
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
}
