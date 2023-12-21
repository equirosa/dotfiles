{ config, pkgs, ... }:
let
  inherit (config.colorScheme) colors;
in
{
  programs.foot = {
    enable = pkgs.stdenv.isLinux;
    server.enable = false;
    settings = {
      colors = with colors; {
        alpha = 0.8;
        background = base00;
        regular0 = base01;
        regular1 = base08;
        regular2 = base0B;
        regular3 = base0A;
        regular4 = base0D;
        regular5 = base07;
        regular6 = base0C;
        regular7 = base05;
        bright0 = base01;
        bright1 = base08;
        bright2 = base0B;
        bright3 = base0A;
        bright4 = base0D;
        bright5 = base07;
        bright6 = base0C;
        bright7 = base05;
      };
      key-bindings = {
        scrollback-up-line = "Control+Shift+k";
        scrollback-down-line = "Control+Shift+j";
      };
      main = {
        bold-text-in-bright = "true";
        font = "monospace:size=14";
      };
      mouse = { };
    };
  };
}
