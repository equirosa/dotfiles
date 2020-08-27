# Interactive stuff
if status --is-interactive
	any-nix-shell fish --info-right | source
	keychain --eval --quiet -Q sourcehut gitlab github codeberg B77F36C3F12720B4 | source
	starship init fish | source
end

if status --is-login
	pgrep -x syncthing >>/dev/null || syncthing & disown
	pgrep -x udiskie >>/dev/null || udiskie & disown
	pgrep -x transmission-da >>/dev/null || transmission-daemon & disown

	switch (tty)
		case "*tty1"
			exec sway
		case "*tty2"
			startx
	end
end
