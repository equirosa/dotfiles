{ pkgs, ... }: {
  home-manager.users.kiri = { config, ... }: {
    home = {
      sessionVariables = {
        PISTOL_CHROMA_FORMATTER = "terminal16m";
        PISTOL_CHROMA_STYLE = "monokai";
      };
    };
    programs.lf = {
      enable = true;
      commands = {
        open = ''''${{for file in "$fx"; do setsid xdg-open "$file" > /dev/null 2> /dev/null & done}}'';
      };
      keybindings = {
        "<backspace2>" = ":set hidden!";
        "<delete>" = ''''$${pkgs.trash-cli}/bin/trash-put "$fx"'';
        D = ''&${pkgs.dragon-drop}/bin/dragon -a -x "$fx"'';
        E = "push \$${config.home.sessionVariables.EDITOR}<space>";
        M = "push \$mkdir<space>-p<space>";
        T = "push \$touch<space>";
        U = ''''${pkgs.mpv}/bin/umpv "$fx"'';
      };
      previewer = {
        keybinding = "i";
        source = "${pkgs.pistol}/bin/pistol";
      };
      settings = {
        incsearch = true;
        ifs = "\\n";
        ratios = "2:4";
        wrapscroll = true;
      };
    };
    xdg.configFile = {
      "pistol/pistol.conf".text = ''
              application/pdf ${pkgs.poppler_utils}/bin/pdftotext %pistol-filename% -
        image/* ${pkgs.viu}/bin/viu %pistol-filename%
        inode/directory ${pkgs.lsd}/bin/lsd -1 %pistol-filename%
        video/* ${pkgs.mediainfo}/bin/mediainfo %pistol-filename%
      '';
    };
  };
}
