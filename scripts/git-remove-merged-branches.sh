git for-each-ref --format '%(refname:short)' refs/heads |
	grep -v "master\|main\|dev" |
	xargs git branch -D
