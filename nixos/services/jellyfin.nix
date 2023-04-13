{ ... }: {
  services.jellyfin = {
    enable = false;
    openFirewall = true;
  };
}
