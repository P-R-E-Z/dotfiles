# Zshell Aliases

# ----------------------------
    FILE EDIT SHORTCUTS
# ----------------------------

alias zshconf="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# ----------------------------
    FOLDER & FILE STRUCTURE
# ----------------------------

alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -p"

# ----------------------------
    NAVIGATION
# ----------------------------

alias ls="ls --color"
alias cat="bat"
alias ports="sudo lsof -i -P -n | grep LISTEN"

# ----------------------------
    GIT
# ----------------------------

# Core Git Stuff
alias gi="git init"
alias gcl="git clone"

alias ga="git add"
alias gaa="git add all"

alias gcm="git commit -m"
alias gca="git commit --ammend --no-edit"
alias gcam="git commit --ammend -m"

alias gp="git push"
alias gs="git status --short"
alias gpull="git pull"

# Undo & Fix
alias gunstage="git reset HEAD --"
alias gundo="git reset --soft HEAD-1"
alias ghard="git reset --hard"

# Merge & Rebase
alias gmt="git mergetool"
alias grb="git rebase"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias gpr="git pull --rebase"

# Stashing
alias gst="git stash"
alias gstp="git stash pop"
alias gstl="git stash list"
alias gstc="git stash clear"

# Inspect
alias gl="git log"
alias gb="git branch"
alias gshow="git remote show origin"
alias gblame="git blame"

# Remote
alias gfetch="git fetch --all --prune"
alias gclean="git clean -xdf"

# ----------------------------
    DEV TOOLS
# ----------------------------

# IDE
alias vs="code ."
alias devup="devcontainer up"
alias nv="nvim"

# Python & Venv
alias py="python3"
alias pd="poetry run python"
alias pt="poetry run pytest"

# Podman
alias pbuild="podman build -t"
alias plogs="podman logs -f"

# FastAPI & Uvicorn
alias apidev="uvicorn app.main:app --reload"
alias apiport="lsof -i :8000"
alias pingapi="curl -I http://localhost:8000"

# Testing
alias ptest="pytext -v --tb=short"
alias testweb="playwright test"
alias testhead="playwright test --headed"

# Docs
alias mkdocsup="mkdocs server"
alias mkdocsbuild="mkdocs build && mkdocs gh-deploy"

# ----------------------------
    SYSTEM
# ----------------------------
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"

# ----------------------------
    FLATPAK
# ----------------------------
alias finstall="flatpak install flathub"
alias flist="flatpak list"
alias funinstall="flatpak uninstall"
