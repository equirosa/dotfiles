{ pkgs, lib, ... }: {
  imports = [ ./kitty.nix ];
  home.packages = lib.attrValues {
    inherit (pkgs)
      mullvad-browser
      ;
  };
}
