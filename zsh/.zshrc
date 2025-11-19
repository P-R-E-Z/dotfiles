export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$(pwd)/.venv/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

# Options
setopt auto_menu menu_complete
setopt autocd
setopt no_case_glob no_case_match
setopt globdots
setopt auto_param_slash

ZSH_THEME="robbyrussell"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

plugins=(git fzf-tab zsh-completions zsh-autosuggestions zsh-syntax-highlighting tmux)

# Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# OMP Prompt Init
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"

fastfetch

alias ls="ls -a"
