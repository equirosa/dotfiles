# Push to all git remotes
for remote in $(git remote); do
	git push "${remote}"
done
