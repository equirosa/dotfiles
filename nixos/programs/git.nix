{
  home-manager.users.kiri = {
    programs = {
      git = {
        enable = true;
        aliases = { };
        attributes = [
          "*.pdf diff=pdf"
        ];
        extraConfig = {
          init = {
            defaultBranch = "main";
          };
        };
        delta = {
          enable = true;
          options = {
            decorations = {
              commit-decoration-style = "bold yellow box
           ul";
              file-decoration-style = "none";
              file-style = "bold yellow ul";
            };
            features = "decorations";
            whitespace-error-style = "22 reverse";
          };
        };
        ignores = [
          "*~"
          "*.swp"
        ];
        signing = {
          key = "03678E9642EB6D9E99974ACFB77F36C3F12720B4";
          signByDefault = true;
        };
        userEmail = "eduardo@eduardoquiros.com";
        userName = "Eduardo Quiros";
      };
      lazygit = {
        enable = true;
        settings = { };
      };
    };
  };
}
