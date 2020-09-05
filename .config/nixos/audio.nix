{ config, pkgs, ... }: {
  hardware.pulseaudio = { enable = true; extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1"; };
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "127.0.0.1"
      }
    '';
    musicDirectory = "/home/eduardo/Music";
    user = "eduardo";
  };
  users.users.eduardo = {
    extraGroups = [ "mpd" ];
    packages = with pkgs; [ mpc_cli ncmpcpp mpdris2 pulsemixer ];
  };
}
