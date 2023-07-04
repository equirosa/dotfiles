# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, modulesPath
, ...
}:
let
  globalBtrfsOpts = [ "compress=zstd:4" "autodefrag" "noatime" ];
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7c50c406-5a37-4bf8-bf44-48daf958e522";
    fsType = "btrfs";
    options = [ "subvol=nixos" ] ++ globalBtrfsOpts;
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/10e5f1df-3228-478c-a505-2ec1861bc374";
  boot.initrd.luks.devices."enc2".device = "/dev/disk/by-uuid/1e4df192-817e-4649-a884-44723fb34b46";
  boot.initrd.luks.devices."enc-swap".device = "/dev/disk/by-uuid/42bb9c1c-1fd4-4a3e-9943-cf03d937d4b9";
  boot.initrd.luks.devices."enc-nvme".device = "/dev/disk/by-uuid/ccccb02b-be56-4e7b-ba5a-eccd4d0ee6c9";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/7c50c406-5a37-4bf8-bf44-48daf958e522";
    fsType = "btrfs";
    options = [ "subvol=home" ] ++ globalBtrfsOpts;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DC5E-C2B3";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/3f464385-9f89-4cd1-8d48-fa8a3a156602"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
