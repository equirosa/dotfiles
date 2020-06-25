#/bin/sh

# Environment Variables
export MONITOR="gotop"\
      PATH="/home/eduardo/.local/share/scripts:$PATH"\
      BROWSER="qutebrowser"\
      EDITOR="nvim"\
      FILE="lf"\
      IMG="imv"\
      MAIL="aerc"\
      TERMINAL="alacritty"\
      LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.cpp=ﭱ:*.js=:*.vimrc=:*.vim=:*.nix=:*.css=:*.pdf=:*.html=:*.rs=:*.rlib=:*.7z=:*.zip=:*.xz=:*.tar=:*.lz=:*.git=:*.webm=:*.mp4=:*.flac=:*.deb=:*.rpm=:*.py=:*.md=:*.json=ﬥ :*.mkv=:*.go=:.git=:*.ts=ﯤ:*.xml=謹:*.drawio=謹"


# Autostarts
eval "$(keychain --eval --quiet --agents ssh --inherit local-once sourcehut github gitlab codeberg vultr-debian)"
udiskie & disown
transmission-daemon & disown
[ "$(tty)" = "/dev/tty1" ] && startx
