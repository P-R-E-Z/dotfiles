#!/usr/bin/env bash

# prez-install.sh - Dotfiles bootstrap script using GNU Stow
# Author: Prez
# Purpose: Automate linking of config files and optional setup tasks

set -euo pipefail

###############################################################################
# Configuration
###############################################################################

DOTFILES_DIR="$HOME/dotfiles"
STOW_MODULES=(zsh tmux git nvim ohmyposh gtk kde scripts logger)

# Flag defaults
DRY_RUN=false
SKIP_SCAFFOLD=false
SKIP_PACKAGES=false
SKIP_STOW=false
SKIP_BOOTSTRAP=false
BOOTSTRAP_ONLY="" # comma‑sep list
UNSTOW_ALL=false
FONT_SCOPE="prompt" # prompt | user | system | none

###############################################################################
# Flag Parsing
###############################################################################
for arg in "$@"; do
  case $arg in
  --dry-run | --test) DRY_RUN=true ;;
  --no-scaffold) SKIP_SCAFFOLD=true ;;
  --no-packages) SKIP_PACKAGES=true ;;
  --no-stow) SKIP_STOW=true ;;
  --no-bootstrap) SKIP_BOOTSTRAP=true ;;
  --bootstrap-only=*) BOOTSTRAP_ONLY="${arg#*=}" ;;
  --unstow-all) UNSTOW_ALL=true ;;
  --fonts=none) FONT_SCOPE="none" ;;
  --fonts=user) FONT_SCOPE="user" ;;
  --fonts=system) FONT_SCOPE="system" ;;
  esac
  shift || true
  export DOTFILES_INSTALL_MODE=${DOTFILES_INSTALL_MODE:-normal}
done

###############################################################################
# Logging helpers
###############################################################################
echo_info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
echo_warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
echo_success() { echo -e "\033[1;32m[DONE]\033[0m $1"; }

# prerequisite
command -v stow >/dev/null || {
  echo -e "\033[1;31m[ERROR]\033[0m GNU Stow not found. Install it first."
  exit 1
}

###############################################################################
# Package Installation
###############################################################################
install_packages() {
  $SKIP_PACKAGES && return
  echo_info "Installing packages via dnf…"
  $DRY_RUN && {
    echo_warn "[DRY RUN] Skipping dnf install"
    return
  }
  if [[ -f $DOTFILES_DIR/packages/fedora.txt ]]; then
    sudo dnf install -y $(grep -vE '^#' "$DOTFILES_DIR/packages/fedora.txt")
  else
    echo_warn "packages/fedora.txt missing – installing fallback minimal set"
    sudo dnf install -y stow git zsh tmux neovim
  fi
  echo_success "Packages installed"
}

###############################################################################
# Stow helpers
###############################################################################
link_dotfiles() {
  $SKIP_STOW && return
  echo_info "Linking modules with Stow…"
  cd "$DOTFILES_DIR"
  for module in "${STOW_MODULES[@]}"; do
    [[ -d $module ]] || {
      echo_warn "Skipping $module (missing)"
      continue
    }
    if ! $DRY_RUN; then stow -v "$module"; else echo_warn "[DRY RUN] Would stow $module"; fi
  done
  echo_success "Stow complete"
}

unstow_all() {
  echo_info "Removing all stow links…"
  cd "$DOTFILES_DIR"
  for module in "${STOW_MODULES[@]}"; do stow -D "$module" 2>/dev/null || true; done
  echo_success "All links removed"
}

###############################################################################
# Font installer
###############################################################################
install_fonts() {
  local SRC="$DOTFILES_DIR/fonts/.local/share/fonts"
  local SYS_DIR="/usr/share/fonts/truetype/prez"
  local USER_DIR="$HOME/.local/share/fonts"

  [[ $FONT_SCOPE == none ]] && {
    echo_info "Skipping fonts (--fonts=none)"
    return
  }
  [[ -d $USER_DIR && $FONT_SCOPE == user ]] && {
    echo_info "User fonts already present – skipping"
    return
  }
  [[ -d $SYS_DIR && $FONT_SCOPE == system ]] && {
    echo_info "System fonts already present – skipping"
    return
  }

  if [[ $FONT_SCOPE == prompt ]]; then
    echo_info "Fonts enhance themes and editors. Choose install scope:"
    echo " 1) System‑wide  2) User‑only (default)"
    read -rp "Selection [1/2]: " sel
    FONT_SCOPE=$([[ $sel == 1 ]] && echo system || echo user)
  fi

  if [[ $FONT_SCOPE == system ]]; then
    echo_info "Installing fonts system‑wide…"
    $DRY_RUN && {
      echo_warn "[DRY RUN] Would copy to $SYS_DIR"
      return
    }
    sudo mkdir -p "$SYS_DIR" && sudo cp -r "$SRC"/* "$SYS_DIR/" && sudo fc-cache -fv "$SYS_DIR"
  else
    echo_info "Installing fonts for user…"
    $DRY_RUN && {
      echo_warn "[DRY RUN] Would copy to $USER_DIR"
      return
    }
    mkdir -p "$USER_DIR" && cp -r "$SRC"/* "$USER_DIR/" && fc-cache -fv "$USER_DIR"
  fi
  echo_success "Fonts installed ($FONT_SCOPE)"
}

###############################################################################
# Bootstraps (unchanged)
###############################################################################
bootstrap_tpm() {
  $DRY_RUN && {
    echo_warn "[DRY RUN] Skipping TPM"
    return
  }
  [[ ! -d $HOME/.tmux/plugins/tpm ]] && git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" && echo_success "TPM done"
}
bootstrap_lazy_nvim() {
  $DRY_RUN && {
    echo_warn "[DRY RUN] Skipping Lazy.nvim"
    return
  }
  [[ ! -d $HOME/.config/nvim/lazy/lazy.nvim ]] && git clone https://github.com/folke/lazy.nvim.git "$HOME/.config/nvim/lazy/lazy.nvim" && echo_success "Lazy.nvim done"
}
bootstrap_ohmyzsh() {
  $DRY_RUN && {
    echo_warn "[DRY RUN] Skipping Oh‑My‑Zsh"
    return
  }
  [[ ! -d $HOME/.oh-my-zsh ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && echo_success "Oh‑My‑Zsh done"
}
bootstrap_pyenv() {
  $DRY_RUN && {
    echo_warn "[DRY RUN] Skipping pyenv"
    return
  }
  command -v pyenv >/dev/null || { curl https://pyenv.run | bash && echo_success "pyenv done"; }
}
bootstrap_asdf() {
  $DRY_RUN && {
    echo_warn "[DRY RUN] Skipping asdf"
    return
  }
  [[ ! -d $HOME/.asdf ]] && git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.0 && echo_success "asdf done"
}

run_bootstraps() {
  $SKIP_BOOTSTRAP && {
    echo_info "Skipping bootstraps"
    return
  }
  if [[ -z $BOOTSTRAP_ONLY ]]; then
    bootstrap_tpm
    bootstrap_lazy_nvim
    bootstrap_ohmyzsh
    bootstrap_pyenv
    bootstrap_asdf
  else
    IFS="," read -ra list <<<"$BOOTSTRAP_ONLY"
    for item in "${list[@]}"; do case $item in tpm) bootstrap_tpm ;; lazy) bootstrap_lazy_nvim ;; ohmyzsh) bootstrap_ohmyzsh ;; pyenv) bootstrap_pyenv ;; asdf) bootstrap_asdf ;; esac done
  fi
}

###############################################################################
# Scaffold structure (unchanged)
###############################################################################
scaffold_structure() {
  $SKIP_SCAFFOLD && return
  echo_info "Creating skeleton directories…"
  mkdir -p "$DOTFILES_DIR"/{zsh,tmux,git,nvim/.config/nvim,ohmyposh/.config/ohmyposh,gtk/.config/gtk-3.0,gtk/.config/gtk-4.0,kde/.config,scripts,packages,logger}
  touch "$DOTFILES_DIR"/zsh/.zshrc "$DOTFILES_DIR"/tmux/.tmux.conf "$DOTFILES_DIR"/git/.gitconfig
  touch "$DOTFILES_DIR"/nvim/.config/nvim/{init.lua,lazy.lua} "$DOTFILES_DIR"/ohmyposh/.config/ohmyposh/theme.omp.json
  touch "$DOTFILES_DIR"/gtk/.config/gtk-3.0/settings.ini "$DOTFILES_DIR"/gtk/.config/gtk-4.0/settings.ini "$DOTFILES_DIR"/kde/.config/kdeglobals
  touch "$DOTFILES_DIR"/scripts/example.sh
  echo_success "Scaffold complete"
}

###############################################################################
# Main
###############################################################################
main() {
  $UNSTOW_ALL && {
    unstow_all
    return
  }
  install_packages
  scaffold_structure
  link_dotfiles
  install_fonts
  run_bootstraps
  echo_success "Dotfiles setup complete. Restart your shell or source configs."
}

main
