restow-all() {
    cd ~/dotfiles
    stow -D */  # Removes old symlinks in dotfiles
    stow */     # Stows every directory in dotfiles
}
