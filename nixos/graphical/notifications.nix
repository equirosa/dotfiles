_: let
  colors = import ../colors.nix;
in {
  services.mako = with colors.selected; {
    enable = true;
    backgroundColor = "#${background}";
    borderColor = "#${bright.yellow}";
    borderRadius = 15;
    borderSize = 2;
    defaultTimeout = 5000;
    font = "monospace 14";
    height = 110;
    layer = "top"; # Consider overlay
    markup = true;
    sort = "-time";
    extraConfig = with regular; ''
      [urgency=low]
      border-color=#${green}

      [urgency=normal]
      border-color=#${yellow}

      [urgency=high]
      border-color=#${red}
      default-timeout=0

      [category=mpd]
      border-color=#${blue}
      default-timeout=2000
      group-by=category
    '';
  };
}
