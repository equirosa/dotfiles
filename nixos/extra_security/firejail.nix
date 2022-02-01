{ pkgs, lib, ... }: {
  programs = {
    firejail = {
      enable = true;
      wrappedBinaries = {
        /* firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
          }; */
        librewolf = {
          executable = "${pkgs.lib.getBin pkgs.nur.repos.wolfangaukang.librewolf}/bin/librewolf";
          profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
        };
      };
    };
  };
}
