if status --is-interactive
	keychain --eval --quiet -Q sourcehut gitlab github codeberg B77F36C3F12720B4 | source
end

starship init fish | source
