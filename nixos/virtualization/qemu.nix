{ config
, pkgs
, ...
}: {
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };
    };
  };
  programs.dconf.enable = true;
  users.users.kiri = {
    extraGroups = [ "libvirtd" ];
    packages = with pkgs; [
      virt-manager
      quickemu
      spice-gtk
    ];
  };
}
