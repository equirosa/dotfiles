nixos-rebuild build --upgrade &&
	nvd diff /run/current-system ./result && rm ./result
