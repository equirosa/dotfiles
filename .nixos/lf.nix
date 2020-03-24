{ config, pkgs, ... }: {
  environment = {
    sessionVariables = { FILE = "lf"; };
    systemPackages = with pkgs; [
      lf
      atool
      glow
      highlight
      lzip
      mediainfo
      poppler_utils
      zstd
      zip
    ];
  };
}
