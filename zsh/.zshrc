eval "$(starship init zsh)"


# Exports
export XDG_CONFIG_HOME="$HOME/.config"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# Aliases
alias ls="eza --icons --oneline"
alias lsa="eza --long --header --inode --git -a"
alias lst="eza --icons --oneline --tree -a --git-ignore"

alias spotify="spotify_player"


# Run Fastfetch once on startup
if [ -z "$TMUX" ]; then
	fastfetch -c examples/10;
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/simongubitz/.lmstudio/bin"
# End of LM Studio CLI section

