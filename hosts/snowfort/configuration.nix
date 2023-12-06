{
  imports = [
    ../global.nix
    ../../nixos/global.nix
    ../../nixos/flatpak.nix
    ../../nixos/bluetooth.nix
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Set your time zone.
  time.timeZone = "America/Costa_Rica";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking = {
    hostName = "snowfort"; # Define your hostname.
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
  };

  programs.adb.enable = true;
  virtualisation.waydroid.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.btrbk.instances.btrbk = {
    onCalendar = "*:0/10";
    settings = {
      snapshot_preserve_min = "2d";
      volume."/" = {
        subvolume = { home = { snapshot_create = "ondemand"; }; };
        target = "/run/media/kiri/3e80dac5-95d8-4234-ab76-acb2f167f797/snapshots";
      };
    };
  };
  users.users.btrbk.extraGroups = [ "wheel" ]; # Need to add it since I have security.sudo.execWheelOnly set to `true`

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kiri = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
