# One CLI to format the code tree - https://github.com/numtide/treefmt
{
  projectRootFile = "flake.nix";
  programs = {
    deadnix.enable = true;
    nixpkgs-fmt.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
  };
}
