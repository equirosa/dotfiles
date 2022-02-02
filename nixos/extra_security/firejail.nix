{ pkgs, lib, ... }: {
  programs = {
    firejail = {
      enable = true;
      wrappedBinaries = {
        element-desktop = {
          executable = "${pkgs.element-desktop}/bin/element-desktop";
          profile = "${pkgs.firejail}/etc/firejail/element-desktop.profile";
        };
        /* firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
          }; */
      };
    };
  };
}
