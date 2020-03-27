{ config, pkgs, ... }: {
  services = {
    tor = {
      enable = true;
      client = {
        enable = true;
        dns.enable = true;
        privoxy.enable = true;
      };
      relay = {
        enable = true;
        port = 143;
        role = "relay";
      };
      torsocks.enable = true;
    };
  };
}
