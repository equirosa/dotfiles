{ config, pkgs, ... }: {
  home-manager.users.eduardo = { pkgs, ... }: {
    home = {
      file = {
        lfpreview = {
          executable = true;
          source = ./config/lf/preview;
          target = ".config/lf/preview";
        };
        lfrc = {
          source = ./config/lf/lfrc;
          target = ".config/lf/lfrc";
        };
      };
      packages = [ pkgs.lf ];
    };
  };
  environment = {
    systemPackages = with pkgs; [ atool glow highlight lzip mediainfo poppler_utils zstd zip ];
      sessionVariables = {
        LF_ICONS =
          "di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.cpp=ﭱ:*.js=:*.vimrc=:*.vim=:*.nix=:*.css=:*.pdf=:*.html=:*.rs=:*.rlib=:*.7z=:*.git=:*.webm=:*.mp4=:*.flac=:*.deb=:*.rpm=:*.py=:*.md=:*.json=ﬥ:*.mkv=:*.go=";
      };
  };
}
