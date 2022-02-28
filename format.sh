#!/bin/sh

# find . -iname '*.nix' -exec nixpkgs-fmt {} \;
alejandra ./nixos/
