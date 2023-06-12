flake_path="${HOME}/projects/dotfiles"
regen_home() {
	home-manager switch --flake "${flake_path}#main"
}

regen_nixos() {
	sudo nixos-rebuild switch --flake "${flake_path}#$(hostname)"
}

test_run() {
	cd "$(mktemp -d)"
	home-manager build --flake "${flake_path}#main"
	nixos-rebuild build --flake "${flake_path}#$(hostname)"
}

regen_all() {
	regen_nixos
	regen_home
}

case "${1}" in
	"home") regen_home ;;
	"os") regen_nixos ;;
	"all") regen_all;;
	"test") test_run ;;
esac
