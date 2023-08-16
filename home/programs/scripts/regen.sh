flake_path="${HOME}/projects/dotfiles"
regen_nixos() {
	sudo nixos-rebuild switch --flake "${flake_path}#$(hostname)"
	notify-send "System Rebuilt!"
}

test_run() {
	cd "$(mktemp -d)"
	nixos-rebuild build --flake "${flake_path}#$(hostname)"
	nvd diff /run/current-system/ ./result
}

if [ $# -eq 0 ]; then
	regen_nixos
else
	case "${1}" in
		"test") test_run ;;
		"os" | *) regen_nixos ;;
	esac
fi
