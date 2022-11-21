{ config, pkgs, lib, ... }:
let
  inherit (lib) getExe recursiveUpdate;
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
        "text/*" = "${getExe pkgs.bat} --plain --paging=never --force-colorization %pistol-filename% -";
        "application/pdf" = "${pkgs.poppler_utils}/bin/pdftotext -layout %pistol-filename% -";
        "inode/directory" = "${getExe pkgs.lsd} -1 %pistol-filename%";
        "video/*" = "${getExe pkgs.mediainfo} %pistol-filename%";
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
          D = "&${getExe pkgs.xdragon} --all --and-exit \"$fx\"";
          E = "push \$\${EDITOR}<space>";
          L = "\$${getExe pkgs.lazygit}";
          M = "push \$mkdir<space>-p<space>";
          T = "push \$touch<space>";
          e = "\$\${EDITOR} $fx";
          U = ''umpv "$fx"'';
          zx = "\$${getExe pkgs.archiver} unarchive \"$fx\"";
        }
        (optionalAttrs zoxideEnabled {
          zi = ":zoxide_interactive";
          zz = "push :zoxide<space>";
        });
      previewer = {
        keybinding = "i";
        source = "${getExe pkgs.pistol}";
      };
      settings = {
        icons = true;
        incsearch = true;
        ifs = "\\n";
        ratios = "2:4";
        shell = "${getExe pkgs.dash}";
        wrapscroll = true;
      };
    };
  };
  # TODO: consider contributing a default icons file for this module
  xdg.configFile."lf/icons".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
}
