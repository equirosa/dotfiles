{ pkgs, lib, ... }: {
  programs = {
    firejail = {
      enable = true;
      wrappedBinaries = {
        discord = {
          executable = "${pkgs.discord}/bin/discord";
          profile = "${pkgs.firejail}/etc/firejail/discord.profile";
        };
        element-desktop = {
          executable = "${pkgs.element-desktop}/bin/element-desktop";
          profile = "${pkgs.firejail}/etc/firejail/element-desktop.profile";
        };
        /* firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
          }; */
        qutebrowser = {
          executable = "${pkgs.qutebrowser}/bin/qutebrowser";
          profile = "${pkgs.firejail}/etc/firejail/qutebrowser.profile";
        };
      };
    };
  };
}
