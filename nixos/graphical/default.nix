_: {
  imports = [ ./hyprland.nix ./sway.nix ];
  home-manager.users.kiri = {
    imports = [ ./waybar.nix ./notifications.nix ];
  };
}
