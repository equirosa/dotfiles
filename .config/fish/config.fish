if status --is-interactive
	keychain --eval --quiet -Q sourcehut gitlab github codeberg | source
end

starship init fish | source
