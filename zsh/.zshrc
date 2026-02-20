eval "$(starship init zsh)"

# zsh initialization
autoload -Uz compinit && compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
setopt EXTENDED_GLOB
bindkey -v
bindkey '\M-e' autosuggest-accept

# Aliases
alias ls="eza --icons --oneline"
alias lsa="eza --long --header --inode --git -a"
alias lst="eza --icons --oneline --tree -a --git-ignore"

alias spotify="spotify_player"

# Lazy load nvm only when needed
_lazy_nvm_load() {
  unset -f nvm node npm npx corepack
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

for cmd in nvm node npm npx corepack; do
  eval "$cmd() { _lazy_nvm_load; $cmd \"\$@\"; }"
done

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
