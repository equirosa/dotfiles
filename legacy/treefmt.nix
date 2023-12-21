# One CLI to format the code tree - https://github.com/numtide/treefmt
{
  projectRootFile = "flake.nix";
  programs = {
    # Lua
    stylua.enable = true;
    # Nix
    deadnix.enable = true;
    nixpkgs-fmt.enable = true;
    statix.enable = true;
    # Shell
    shellcheck.enable = true;
    shfmt.enable = true;
  };
}
