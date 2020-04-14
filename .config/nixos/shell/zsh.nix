{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting = { enable = true; };
  };
  home-manager.users.eduardo = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      defaultKeymap = "vicmd";
      dotDir = ".config/zsh";
      history = {
        ignoreDups = true;
        path = ".cache/zsh_history";
      };
    };
  };
}
