{ config, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.alacritty = {
      enable = true;
      settings = {
        background_opacity = 0.8;
        colors = {
          normal = {
            black = "0x000000";
            red = "0xBB2222";
            green = "0x22BB22";
            yellow = "0xBBBB22";
            blue = "0x2222BB";
            magenta = "0xBB22BB";
            cyan = "0x22BBBB";
            white = "0xDDDDDD";
          };
          bright = {
            black = "0x888888";
            red = "0xFF2222";
            green = "0x22FF22";
            yellow = "0xFFFF22";
            blue = "0x2222FF";
            magenta = "0xFF22FF";
            cyan = "0x22FFFF";
            white = "0xFFFFFF";
          };
        };
        font = {
          size = 12;
          normal = {
            family = "Fira Code";
          };
        };
      };
    };
  };
  environment.sessionVariables = {
    TERMINAL = "alacritty";
  };
}
