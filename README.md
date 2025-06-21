# Prez's Dotfiles (WIP WILL DELETE THIS WHEN INSTALL SCRIPT IS READY) 

> Modular dotfiles setup for developers who live in the terminal — shout out to [GNU Stow](https://www.gnu.org/software/stow/) — designed for my Fedora 42 dev environment.

---

## Quickstart

```bash
git clone https://github.com/prez/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash prez-install.sh 
```

Safe installation via:
```bash
bash prez-install.sh --dry-run  # preview everything
```

---

## Modules Included

Each module lives in its own folder and is symlinked into place using Stow:

| Module      | Description                                     |
|-------------|-------------------------------------------------|
| `zsh`       | Zsh config, themes, alias packs                 |
| `tmux`      | Custom `.tmux.conf` with TPM support            |
| `git`       | Global `.gitconfig`, optional ignores           |
| `nvim`      | Neovim IDE config with Lazy.nvim bootstrap      |
| `ohmyposh`  | JSON prompt theme compatible with Posh shell    |
| `gtk`, `kde`| UI polish — themes, cursor fixes, integrations  |
| `scripts`   | Startup, sync, and system helper scripts        |
| `logger`    | WIP – install/download activity tracker      |

---

## Features

- ** DRY-RUN Mode:** preview installs before committing
- ** Modular Design:** each tool is separated cleanly
- ** Sensible Defaults:** modern, fast, focused
- ** Learnable:** everything was configured by me, for me
- ** Pluggable:** easily extend to i3, Hyprland, etc.

---

## Automation Hooks

Included out-of-the-box:
- **TPM (tmux plugin manager)** auto-install
- **Lazy.nvim** bootstraps itself on first launch
- **Oh My Zsh** installs if not detected
- **`pyenv` & `asdf`** support baked in
- **More soon**

---

## Built For Fedora

Tested on:
- Fedora Workstation 42 (Plasma & Wayland)
- `dnf`, `systemd`, SELinux-friendly (WIP)

Can be ported to:
- Arch (with `pacman.txt`)
- Debian (with `apt.txt`)

---

## Contributing

This is my personal setup — but PRs for fixes, improved defaults, or better modularity are welcome.

Want to package or CI this? See [dotfiles-build](https://github.com/prez/dotfiles-build)

---

## License

MIT — use it, fork it, break it, make it yours.

---

> Built by [@prez](https://github.com/prez) — proud dotfiles addict

