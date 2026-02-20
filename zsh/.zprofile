if [[ "$OSTYPE" == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Exports
export XDG_CONFIG_HOME="$HOME/.config"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export NVM_DIR="$HOME/.nvm"

if [[ "$OSTYPE" == darwin* ]]; then
  export PATH="$PATH:$HOME/.lmstudio/bin"
fi

# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
