{pkgs, ...}: {
  hardware.keyboard.zsa.enable = true;
  users.users.kiri.packages = [pkgs.wally-cli];
}
