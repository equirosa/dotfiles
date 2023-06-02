{pkgs, ...}: {
  systemd.user.services.swww = let
    swww = "${pkgs.swww}/bin/swww";
  in {
    Unit.Description = "Run swww init for graphical-session.target";
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      Type = "simple";
      ExecStart = "${swww}/bin/swww init && ${swww} img Pictures/desktop_backgrounds/gifs/city.gif";
      Restart = "always";
    };
  };
}
