# main settings here, will be making this more module soon!

# Sourcing ZSH Modular files
[ -f "~/.zshrc.d/aliases" ] && source "~/.zshrc.d/aliases"
[ -f "~/.zshrc.d/functions" ] && source "~/.zshrc.d/functions"

# Modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Options
setopt auto_menu menu_complete # Auto completes
setopt autocd # Type out dir without cd if ya want
setopt no_case_glob no_case_match # Makes completion case sensitive
setopt globdots
setopt auto_param_slash # Adds / instead of trail space

# History Options
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt append_history
setopt share_history
setopt inc_append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# fzf
source <(fzf --zsh) # allows fzf hist widget

# Keybinds (trying to keep it close to vim motions)
bindkey "^0" beginning-of-line
bindkey "^$" end-of-line
bindkey "^w" forward-word
bindkey "^b" backward-word
bindkey "^W" history-search-forward
bindkey "^B" history-search-backward
bindkey "^R" fzf-history-widget

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode reminder 

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='neovim'
 else
   export EDITOR='neovim'
 fi

# Run fastfetch on startup if installed
if command -v fastfetch >/dev/null 2>&1; then
	fastfetch
fi

# Plugins
plugins=(
  git
  fzf-tab
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Completion Options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# OMP Prompt Init
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
