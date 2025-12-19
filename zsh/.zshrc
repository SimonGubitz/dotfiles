eval "$(starship init zsh)"


if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi


# Run Neofetch once on startup
neofetch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
