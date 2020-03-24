{ config, pkigs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        gaps = {
          inner = 5;
          outer = 5;
          smartBorders = "on";
          smartGaps = true;
        };
        modifier = "Mod4";
        terminal = "$TERMINAL";
      };
    };
  };
}
