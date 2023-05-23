cd "$(mktemp -d)"

nixos-rebuild build --fast \
	&& nvd diff /run/current-system ./result
