{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ xclip ];
  services = {
    xserver = {
      enable = true;
      layout = "us,latam";
      xkbOptions = "grp:win_space_toggle,ctrl:nocaps";
      libinput.enable = true;
    };
  };
}
