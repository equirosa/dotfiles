{
  description = "Kiri's NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux"];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    devShell = forAllSystems (
      system: let
        pkgs = nixpkgsFor.${system};
      in
        pkgs.mkShell
        {
          buildInputs = with pkgs; [
            rnix-lsp
            statix
            (writeShellApplication {
              name = "format";
              text = ''${pkgs.alejandra}/bin/alejandra "$(pwd)"'';
            })
          ];
        }
    );
  };
}
