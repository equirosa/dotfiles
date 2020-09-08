{ config, pkgs, ... }: {
  imports = [ ./picom.nix ];
  programs = {
    slock.enable = true;
  };
  environment = {
    #sessionVariables = { LOCK_CMD = "slock"; };
    systemPackages = with pkgs; [
      dmenu
      maim
      sxhkd
      xclip
      xdo
      xidlehook
      xorg.xkill
      st
    ];
  };
  services = {
    redshift.enable = true;
    unclutter = { enable = true; };
    xserver = {
      enable = true;
      layout = "us,latam";
      xkbOptions = "grp:win_space_toggle,ctrl:nocaps";
      libinput = {
        enable = true;
        disableWhileTyping = true;
      };
    };
  };
}
