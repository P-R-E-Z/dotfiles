# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode reminder 

# Plugins
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='neovim'
 else
   export EDITOR='neovim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
-------------------------------------
# Stow
-------------------------------------
# OMP Init
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"

# Run afetch on startup if installed
if command -v afetch >/dev/null 2>&1; then
	fastfetch
fi

# Stow Function
restow() {
  cd ~/dotfiles && stow -Dv "$1" && stow -v "$1"
}
