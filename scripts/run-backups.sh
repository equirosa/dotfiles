BORG_PASSPHRASE="$(prs show -q backups/borg/snowfort/borgbase)"
export BORG_PASSPHRASE
BORG_BACKUP_FORMAT="{hostname}-{user}-{now}"
LBLUE="\033[1;34m"
LGREEN="\033[1;32m"
NC="\033[0m"

print_success() {
	printf "%b%s%b\n" "${LGREEN}" "${1}" "${NC}"
}

print_announce() {
	printf "%b%s%b\n" "${LBLUE}" "${1}" "${NC}"
}

print_announce "Starting Backup to BorgBase"
borg create --progress --verbose --stats --checkpoint-interval 600 hvwib450@hvwib450.repo.borgbase.com:repo::"${BORG_BACKUP_FORMAT}" \
	~/Documents/ \
	~/Downloads/ \
	~/Games/itch/ \
	~/Music/ \
	~/Sync/ \
	~/Pictures/ \
	~/Templates/ \
	~/Videos/ \
	~/dotfiles/ \
	~/projects \
	~/.local/share/libvirt/ \
	--exclude "${HOME}/projects/nixpkgs/" \
	--exclude "*/league-of-legends/*" \
	--exclude "*/node_modules/*" \
	--exclude "*/oses/*" \
	--exclude '*/.stfolder' \
	--exclude '*/battlenet' \
	--exclude '*/epic' \
	--exclude '*/rocket-league' \
	--exclude "*/.direnv/" \
	--exclude "*/.git/" \
	--exclude "*/.var/" \
	--exclude "*/target/" \
	--exclude "*/torrented" \
	--exclude "*/unhidden" \
	--exclude "*/.thumbnails" \
	--compression auto,zstd,10 &&
	print_announce "PRUNING" &&
	borg prune --progress --verbose --stats --save-space --keep-daily=7 --keep-monthly=-1 --keep-weekly=4 --keep-within=1d \
		hvwib450@hvwib450.repo.borgbase.com:repo &&
	print_success "BACKUP TO BORGBASE SUCCESSFUL!"
