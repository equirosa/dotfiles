{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.swww = {
    Unit = {
      After = ["graphical-session.target"];
      Description = "Run swww init for graphical-session.target";
      PartOf = ["graphical-session.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStart =
        pkgs.writeShellScript "swww-init"
        "${lib.getExe pkgs.swww} init";
      Restart = "on-failure";
    };
  };
}
