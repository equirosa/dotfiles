{ pkgs, lib, ... }: {
  programs = {
    firejail = {
      enable = true;
      wrappedBinaries = {
        firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        };
      };
    };
  };
}
