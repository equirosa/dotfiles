{ pkgs, ... }: {
  systemd.user.services.thunderbird = {
    Unit = {
      Description = "Run Thunderbird";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.thunderbird}/bin/thunderbird";
      Restart = "always";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical.target" ];
    };
  };
}
