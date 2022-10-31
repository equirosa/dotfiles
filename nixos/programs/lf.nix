{ config, pkgs, lib, ... }:
let
  inherit (lib) recursiveUpdate;
  inherit (lib.attrsets) optionalAttrs;
  zoxideEnabled = config.programs.zoxide.enable;
  zoxideCommands = {
    zoxide = ''
      %{{
        result="$(zoxide query --exclude "''${PWD}" -- "$@")"
        lf -remote "send ''${id} cd ''${result}"
      }}
    '';
    zoxide_interactive = ''
      ''${{
        result="$(zoxide query -i -- "$@")"
        lf -remote "send ''${id} cd ''${result}"
      }}
    '';
  };
in
{
  programs = {
    pistol = {
      enable = true;
      config = {
        "text/*" = "${pkgs.bat}/bin/bat --plain --paging=never --force-colorization %pistol-filename% -";
        "application/pdf" = "${pkgs.poppler_utils}/bin/pdftotext -layout %pistol-filename% -";
        "inode/directory" = "${pkgs.lsd}/bin/lsd -1 %pistol-filename%";
        "video/*" = "${pkgs.mediainfo}/bin/mediainfo %pistol-filename%";
      };
    };
    lf = {
      enable = true;
      commands = recursiveUpdate
        {
          on-cd = ''
            &{{
            printf "\033]0; $(pwd | sed "s|$HOME|~|") - lf\007" > /dev/tty
            }}
          '';
          open = ''
            ''${{for file in "$fx"; do
            setsid xdg-open "$file" > /dev/null 2> /dev/null &
            done}}
          '';
        }
        (optionalAttrs
          zoxideEnabled
          zoxideCommands);
      keybindings = recursiveUpdate
        {
          "<backspace2>" = ":set hidden!";
          "<delete>" = "\$${pkgs.trash-cli}/bin/trash-put \"$fx\"";
          D = "&${pkgs.xdragon}/bin/dragon --all --and-exit \"$fx\"";
          E = "push \$\${EDITOR}<space>";
          L = "\$${pkgs.lazygit}/bin/lazygit";
          M = "push \$mkdir<space>-p<space>";
          T = "push \$touch<space>";
          e = "\$\${EDITOR} $fx";
          U = ''umpv "$fx"'';
          zx = "\$${pkgs.archiver}/bin/arc unarchive \"$fx\"";
        }
        (optionalAttrs zoxideEnabled {
          zi = ":zoxide_interactive";
          zz = "push :zoxide<space>";
        });
      previewer = {
        keybinding = "i";
        source = "${pkgs.pistol}/bin/pistol";
      };
      settings = {
        icons = true;
        incsearch = true;
        ifs = "\\n";
        ratios = "2:4";
        shell = "${pkgs.dash}/bin/dash";
        wrapscroll = true;
      };
    };
  };
  # TODO: consider contributing a default icons file for this module
  xdg.configFile."lf/icons".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
}
