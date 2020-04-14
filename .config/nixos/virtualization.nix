{ config, pkgs, ... }: {
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  virtualisation = { libvirtd = { enable = true; }; };
  users.users.eduardo = {
    extraGroups = [ "libvirtd" ];
    packages = with pkgs; [ virt-manager gnome3.gnome-boxes ];
  };
}
