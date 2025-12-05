eval "$(starship init zsh)"


if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi


# Run Neofetch once on startup
neofetch
