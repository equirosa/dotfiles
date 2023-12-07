{ pkgs, ... }: {
  systemd.user.services.auto-mirror = {
    Unit = {
      Description = "Automatically use scrcpy on adb connection";
      After = [ "graphical.target" ];
    };
    Service = {
      ExecStart = "${pkgs.autoadb}/bin/autoadb ${pkgs.scrcpy} --stay-awake --turn-screen-off -s '{}'";
      Restart = "always";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical.target" ];
    };
  };
  systemd.user.services.beeper = {
    Unit = {
      Description = "Run Beeper";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${pkgs.beeper}/bin/beeper";
      Restart = "always";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical.target" ];
    };
  };
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
