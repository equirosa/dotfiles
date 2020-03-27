{ config, pkgs, ... }: {
  environment = { variables = { ZDOTDIR = "$HOME/.config/zsh"; }; };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    autosuggestions = { enable = true; };
    ohMyZsh = {
      enable = true;
      customPkgs = with pkgs; [ nix-zsh-completions ];
      plugins = [ ];
      theme = "agnoster";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "pattern" ];
      patterns = {
        "rm -rf" = "fg=white,bold,bg=red";
        "sudo" = "fg=yellow,bold,bg=blue";
      };
    };
  };
  users.users.eduardo.shell = pkgs.zsh;
}
