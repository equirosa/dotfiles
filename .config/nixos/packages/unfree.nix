# NOTE: These packages are unfree and a replacement must be found ASAP
{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "anydesk"
      "zoom-us"
      "steam"
      "steam-runtime"
      "steam-original"
    ];
}
