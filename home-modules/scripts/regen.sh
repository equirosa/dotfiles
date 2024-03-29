#!/bin/sh
flake_path="${HOME}/projects/dotfiles"
platform="$(uname -s)"
regen_nixos() {
  case "$platform" in
  "Linux")
    sudo nixos-rebuild switch --flake "${flake_path}"
    notify-send "System Rebuilt!"
    ;;
  "Darwin")
    darwin-rebuild switch --flake "${flake_path}"
    ;;
  *)
    echo "PLATFORM UNKNOWN"
    exit 1
    ;;
  esac
}

test_run() {
  cd "$(mktemp -d)" || exit 1
  case "$platform" in
  "Linux")
    nixos-rebuild build --flake "${flake_path}"
    ;;
  "Darwin")
    darwin-rebuild build --flake "${flake_path}"
    ;;
  *)
    echo "PLATFORM UNKNOWN"
    exit 1
    ;;
  esac
  nvd diff /run/current-system/ ./result
}

revert() {
  sudo nixos-rebuild switch --rollback --flake "${flake_path}"
  notify-send "System Rollback Successful!"
}

if [ $# -eq 0 ]; then
  regen_nixos
else
  case "${1}" in
  "test") test_run ;;
  "revert") revert ;;
  "os" | *) regen_nixos ;;
  esac
fi
