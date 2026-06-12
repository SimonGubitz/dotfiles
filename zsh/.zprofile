if [[ "$OSTYPE" == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="$PATH:$HOME/.lmstudio/bin"
	export XDG_CACHE_HOME="$HOME/Library/Caches/"
else
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
	export XDG_CACHE_HOME="$HOME/.cache"
fi

# Exports
export XDG_CONFIG_HOME="$HOME/.config"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export NVM_DIR="$HOME/.nvm"

# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
