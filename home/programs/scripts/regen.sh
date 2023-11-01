flake_path="${HOME}/projects/dotfiles"
platform="$(uname -s)"
rebuild_command=""
notify_command=""
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
	cd "$(mktemp -d)"
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

if [ $# -eq 0 ]; then
	regen_nixos
else
	case "${1}" in
	"test") test_run ;;
	"os" | *) regen_nixos ;;
	esac
fi
