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
      commands = { open = ''''${{for file in "$fx"; do setsid xdg-open "$file" > /dev/null 2> /dev/null & done}}''; };
      keybindings = {
        "<backspace2>" = ":set hidden!";
        "<delete>" = "\$${pkgs.trash-cli}/bin/trash-put \"$fx\"";
        D = "&${pkgs.xdragon}/bin/dragon -a -x \"$fx\"";
        E = "push \$${config.home.sessionVariables.EDITOR}<space>";
        L = "$${pkgs.lazygit}/bin/lazygit";
        M = "push \$mkdir<space>-p<space>";
        T = "push \$touch<space>";
        U = "\${pkgs.mpv}/bin/umpv \"$fx\"";
        zx = "\$${pkgs.archiver}/bin/arc unarchive \"$fx\"";
      };
      previewer = {
        keybinding = "i";
        source = "${pkgs.pistol}/bin/pistol";
      };
      settings = {
        icons = true;
        incsearch = true;
        ifs = "\\n";
        ratios = "2:4";
        wrapscroll = true;
      };
    };
    xdg.configFile = {
      "pistol/pistol.conf".text = ''
        text/* ${pkgs.bat}/bin/bat --plain --paging=never --force-colorization %pistol-filename% -
        application/pdf ${pkgs.poppler_utils}/bin/pdftotext -layout %pistol-filename% -
        inode/directory ${pkgs.lsd}/bin/lsd -1 %pistol-filename%
        video/* ${pkgs.mediainfo}/bin/mediainfo %pistol-filename%
      '';
    };
  };
}

