{ pkgs
, ...
}:
{
  home.packages = [ pkgs.jq ];
  programs = {
    fish = {
      enable = true;
      shellAbbrs = import ./abbreviations.nix;
      interactiveShellInit = ''
        set -gx EDITOR nvim
        bind \cx 'exec $SHELL'
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      plugins = with pkgs.fishPlugins; [
        { name = "done"; src = done; }
      ];
    };
  };
}
