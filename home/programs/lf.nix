{ pkgs
, ...
}:
{
  programs = {
    lf = {
      enable = true;
      commands =
        {
          on-cd = ''
            &{{
            printf "\033]0; $(pwd | sed "s|$HOME|~|") - lf\007" > /dev/tty
            }}
          '';
          open = ''
            ''${{for file in $fx; do
            setsid xdg-open "$file" > /dev/null 2> /dev/null &
            done}}
          '';
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
      keybindings = {
        "<backspace2>" = ":set hidden!";
        "<delete>" = "\$${pkgs.trash-cli}/bin/trash-put \"$fx\"";
        "<enter>" = "push $";
        D = "&${pkgs.ripdrag}/bin/ripdrag --all --and-exit \"$fx\"";
        E = "push \$\${EDITOR}<space>";
        L = "\$${pkgs.lazygit}/bin/lazygit";
        M = "push \$mkdir<space>-p<space>";
        T = "push \$touch<space>";
        e = "\$\${EDITOR} $fx";
        U = ''umpv "$fx"'';
        zx = "\$${pkgs.archiver}/arc unarchive \"$fx\"";
        # Zoxide
        zi = ":zoxide_interactive";
        zz = "push :zoxide<space>";
      };
      previewer = {
        keybinding = "i";
        source = "${pkgs.ctpv}/bin/ctpv";
      };
      settings = {
        icons = true;
        incsearch = true;
        ratios = "2:4";
        wrapscroll = true;
      };
      extraConfig = ''
        set cleaner ${pkgs.ctpv}/bin/ctpvclear
        &${pkgs.ctpv}/bin/ctpv -s $id
        &${pkgs.ctpv}/bin/ctpvquit $id
      '';
    };
  };
  # TODO: consider contributing a default icons file for this module
  # xdg.configFile."lf/icons".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
}
