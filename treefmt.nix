# One CLI to format the code tree - https://github.com/numtide/treefmt
{
  projectRootFile = "flake.nix";
  programs = {
    nixpkgs-fmt.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
  };
}
