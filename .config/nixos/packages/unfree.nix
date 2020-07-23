# NOTE: These packages are unfree and a replacement must be found ASAP
{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "anydesk" # TODO: Consider replacing with https://remotely.one
      "discord" # TODO: Obviously, replace with matrix or XMPP
      "steam"
      "steam-runtime"
      "steam-original"
    ];
}
