
# Interactive stuff
if status --is-interactive
	keychain --eval --quiet -Q sourcehut gitlab github codeberg B77F36C3F12720B4 | source
	starship init fish | source
end

if status --is-login
	pgrep -x transmission-da || transmission-daemon &;
	switch (tty)
		case "*tty1"
			startx
	end
end
