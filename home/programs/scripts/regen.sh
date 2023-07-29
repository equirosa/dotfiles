flake_path="sourcehut:~eduardo_quiros/dotfiles"
regen_nixos() {
	sudo nixos-rebuild switch --flake "${flake_path}#$(hostname)"
	notify-send "System Rebuilt!"
}

test_run() {
	cd "$(mktemp -d)"
	nixos-rebuild build --flake "${flake_path}#$(hostname)"
	nvd diff /run/current-system/ ./result
}

case "${1}" in
	"test") test_run ;;
	"os" | *) regen_nixos ;;
esac
