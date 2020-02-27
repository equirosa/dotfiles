{ config, ... }: {
  imports = [
    ./audio.nix
    ./auto_upgrades.nix
    ./bat.nix
    ./firefox.nix
    ./flatpak.nix
    ./fonts.nix
    ./fuck.nix
    ./git.nix
    ./global.nix
    ./kdeConnect.nix
    ./kitty.nix
    ./lf.nix
    ./location.nix
    ./mpv.nix
    ./neovim.nix
    ./nix.nix
    ./pass.nix
    ./printing.nix
    ./sway.nix
    ./syncthing.nix
    ./theme.nix
    ./tor.nix
    ./udiskie.nix
    ./user.nix
    ./virtualization.nix
    ./zsh.nix
  ];
  networking.hostName = "frost";
  programs.udevil.enable = true;
  services = {
    borgbackup.jobs = {
      automatic-hourly = {
        appendFailedSuffix = true;
        compression = "auto,zstd,22";
        doInit = false;
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat /home/eduardo/.local/share/borgpassdisco";
        };
        exclude = [
          "/home/eduardo/.config"
          "*/.stfolder"
          "*/.stversions"
          "/home/eduardo/Games/league-of-legends/"
        ];
        paths = "/home/eduardo/";
        prune.keep = {
          within = "1d";
          daily = 14;
          weekly = 4;
          monthly = 4;
        };
        removableDevice = true;
        repo =
          "/run/media/eduardo/2e571771-81db-41a5-a0b6-d5c6d3b8bf88/backups";
        startAt = "hourly";
        user = "eduardo";
      };
    };
    duplicity = {
      enable = true;
      exclude = [
        "/home/eduardo/.config"
        "*/.stfolder"
        "/home/eduardo/.emacs"
        "*/.local"
        "/home/eduardo/.bash*"
      ];
      root = "/home/eduardo";
      secretFile = /home/eduardo/.local/share/duplicity_frost_pass;
      targetUrl = "ftp://frost@eduardoquiros.com@c1560850.ferozo.com";
    };
  };
}
