{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "show-nix-store-path";
      text = ''realpath "$(command -v "''${1}")"'';
    })
    (writeShellApplication {
      name = "show-script";
      text = ''${cat} "$(show-nix-store-path "''${1}")"'';
    })
  ];
}
