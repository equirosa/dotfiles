_: {
  imports = [./hyprland.nix];
  home-manager.users.kiri = {
    imports = [./waybar.nix ./notifications.nix];
  };
}
