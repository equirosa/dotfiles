{
  home-manager.users.kiri = {
    programs = {
      git = {
        enable = true;
        aliases = { };
        attributes = [ "*.pdf diff=pdf" ];
        extraConfig = {
          # init = {defaultBranch = "main";};
          diff = {
            algorithm = "histogram";
            sopsdiffer.textconv = "sops -d";
          };
          merge = {
            tool = "nvimdiff";
          };
        };
        delta = {
          enable = true;
          options = {
            decorations = {
              commit-decoration-style = "bold yellow box ul";
              file-decoration-style = "none";
              file-style = "bold yellow ul";
            };
            features = "decorations";
            whitespace-error-style = "22 reverse";
          };
        };
        ignores = [ "*~" "*.swp" ".direnv" ];
        signing = {
          key = "03678E9642EB6D9E99974ACFB77F36C3F12720B4";
          signByDefault = true;
        };
        userEmail = "eduardo@eduardoquiros.com";
        userName = "Eduardo Quiros";
      };
      lazygit = {
        enable = true;
        settings = {
          git.paging.pager = "delta --dark --paging=never --24-bit-color=never";
        };
      };
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
  };
}
