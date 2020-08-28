# Interactive stuff
if status --is-interactive
	if set -q $TMUX
		exec tmux attach
	end
	any-nix-shell fish --info-right | source
	keychain --eval --quiet -Q sourcehut gitlab github codeberg B77F36C3F12720B4 | source
	starship init fish | source
end
