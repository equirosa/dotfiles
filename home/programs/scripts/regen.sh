flake_path="${HOME}/projects/dotfiles"
regen_home() {
	home-manager switch --flake "${flake_path}#main"
}

regen_nixos() {
	sudo nixos-rebuild switch --flake "${flake_path}#$(hostname)"
}

case "${1}" in
	"home") regen_home ;;
	"os") regen_nixos ;;
	"all") regen_nixos && regen_home ;;
esac
