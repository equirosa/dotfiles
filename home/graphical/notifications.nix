{ config, ... }:
let
  inherit (config.colorScheme) colors;
in
{
  services.mako = with colors; {
    enable = true;
    backgroundColor = "#${base00}";
    borderColor = "#${base0A}";
    borderRadius = 15;
    borderSize = 2;
    defaultTimeout = 5000;
    font = "monospace 14";
    height = 110;
    layer = "top"; # Consider overlay
    markup = true;
    sort = "-time";
    extraConfig = ''
      [urgency=low]
      border-color=#${base0B}

      [urgency=high]
      border-color=#${base08}
      default-timeout=0

      [category=mpd]
      border-color=#${base0D}
      default-timeout=2000
      group-by=category
    '';
  };
}
