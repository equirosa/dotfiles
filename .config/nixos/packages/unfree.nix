# NOTE: These packages are unfree and a replacement must be found ASAP
{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "anydesk" # TODO: Consider replacing with https://remotely.one
      "zoom-us" # TODO: Jisti is immeasurably superior
      "steam"
      "steam-runtime"
      "steam-original"
    ];
}
