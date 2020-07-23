{ config, pkgs, ... }: {
  imports = [ ./picom.nix ];
  programs = {
    slock.enable = true;
  };
  nixpkgs = {
    config = {
      slock = pkgs.stdenv.lib.overrideDerivation pkgs.slock (
        attrs: rec {
          patches = map pkgs.fetchurl [
            {
              url = "https://tools.suckless.org/slock/patches/blur-pixelated-screen/slock-blur_pixelated_screen-1.4.diff";
              sha256 = "0bp4p4rgcx1nbw5a69p0x2j014nsfyxaafzih5ky27kki81ls987";
            }
          ];
        }
      );
      st = pkgs.stdenv.lib.overrideDerivation pkgs.st (
        attrs: rec {
          patches = map pkgs.fetchurl [
            #{
            #url = "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff";
            #sha256 = "11dj1z4llqbbki5cz1k1crr7ypnfqsfp7hsyr9wdx06y4d7lnnww";
            #}
            {
              url = "https://st.suckless.org/patches/gruvbox/st-gruvbox-dark-0.8.2.diff";
              sha256 = "0bhvw1jam9s0km5hwbnicb27sgwzj04msmwc8gvpf2islpnxbcsf";
            }
          ];
        }
      );
    };
  };
  environment = {
    sessionVariables = { LOCK_CMD = "i3lock-fancy -p"; };
    systemPackages = with pkgs; [
      betterlockscreen
      dmenu
      maim
      sxhkd
      xclip
      xdo
      xdotool
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
