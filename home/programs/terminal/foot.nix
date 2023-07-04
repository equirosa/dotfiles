{ colors, ... }: {
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      colors = with colors;
        with selected; {
          alpha = "${opacity}";
          background = "${regular.black}";
          regular0 = "${regular.black}";
          regular1 = "${regular.red}";
          regular2 = "${regular.green}";
          regular3 = "${regular.yellow}";
          regular4 = "${regular.blue}";
          regular5 = "${regular.magenta}";
          regular6 = "${regular.cyan}";
          regular7 = "${regular.white}";
          bright0 = "${bright.black}";
          bright1 = "${bright.red}";
          bright2 = "${bright.green}";
          bright3 = "${bright.yellow}";
          bright4 = "${bright.blue}";
          bright5 = "${bright.magenta}";
          bright6 = "${bright.cyan}";
          bright7 = "${bright.white}";
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
