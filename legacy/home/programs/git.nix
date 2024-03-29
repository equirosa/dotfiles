{ pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      aliases = {
        diff-words = "diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'";
      };
      attributes = [ "*.pdf diff=pdf" "*.md diff=md" ];
      extraConfig = {
        diff = {
          tool = "difftastic";
          algorithm = "histogram";
          sopsdiffer.textconv = "sops -d";
        };
        difftool.prompt = false;
        difftool."difftastic".cmd = ''difft "$LOCAL" "$REMOTE"'';
        merge.tool = "nvimdiff";
        pager.difftool = true;
        push.autoSetupRemote = true;
        url = {
          "ssh://git@github.com/".insteadOf = "https://github.com/";
        };
      };
      difftastic = {
        enable = true;
        background = "dark";
      };
      ignores = [ "*~" "*.swp" ".direnv" ".DS_Store" ];
      signing = {
        key = "03678E9642EB6D9E99974ACFB77F36C3F12720B4";
        signByDefault = pkgs.stdenv.isLinux;
      };
      userEmail = "eduardo@eduardoquiros.com";
      userName = "Eduardo Quiros";
    };
    lazygit.enable = true;
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
  };
}
