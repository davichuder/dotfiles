# my dotfiles

Plain dotfiles repository, made for the [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html)
dotfiles module and consumed by
[dev-setup](https://github.com/davichuder/dev-setup) through its
`mise.dotfiles.toml` module.

## What this is (and why not chezmoi)

This is deliberately a **plain-file repo**: files on disk are exactly the content
that lands at the target path — no templates, no `run_*` scripts, no pre- or
post-install hooks. All mapping logic lives *outside* the repo, declared in
dev-setup's `mise.dotfiles.toml`:

```toml
[bootstrap.repos]
"~/dotfiles" = { url = "https://github.com/davichuder/dotfiles.git", ref = "main" }

[dotfiles]
"~/.config/nvim" = "~/dotfiles/nvim"
```

Each `[dotfiles]` entry is a single mapping: destination (live path) → source
(path inside this repo). Some tool that might plain-read this repo expecting a
manager-specific layout stays custom: it is not a chezmoi-style source tree
(`chezmoi` templates like `dot_zshrc.tmpl` don't exist here) and not a stow
package tree either. If you want to use it with a different tool, wire your own
mapping table — nothing in this repo assumes one.

## Connection to dev-setup

The `dotfiles` module there is **OFF by default**; it applies only when you opt
in: `./bootstrap.sh <module> --dotfiles` (interactive runs ask about dotfiles;
Enter keeps the default `dotfiles_url`, which is this repository). The module
clones this repo into `~/dotfiles` and then applies the declared mappings.

The mapping side lives in dev-setup; this repo only guarantees:

- a single `main` branch with at least one commit (mise requires it before apply)
- every mapped source path exists here when a `[dotfiles]` entry points to it
- no secrets: ssh keys, cloud credentials, tokens (`.ssh/`, `.aws/`,
  `.config/gh/hosts.yml`, `*.env`, `*.secret`, `*.keys`) are blocked by
  `.gitignore` and never committed

## Layout

```
zsh/zshrc    shell config           (mapped to ~/.zshrc)
zsh/zshenv   per-shell env (PATH)   (mapped to ~/.zshenv)
p10k.zsh     powerlevel10k config   (mapped to ~/.p10k.zsh)
ghostty/     Ghostty config         (mapped to ~/.config/ghostty/config)
bat/         bat config             (mapped to ~/.config/bat/config)
ripgrep/     ripgrep CLI defaults   (mapped to ~/.config/ripgrep/config)
fd/          fd ignore patterns     (mapped to ~/.config/fd/ignore)
yazi/        yazi TUI defaults      (mapped to ~/.config/yazi/yazi.toml)
git/         git + delta config     (mapped to ~/.gitconfig)
lazygit/     Lazygit config         (mapped to ~/.config/lazygit/config.yml)
gh/          gh CLI config          (mapped to ~/.config/gh/config.yml)
nvim/        LazyVim starter        (mapped to ~/.config/nvim)
```

## Current mappings

| Live path           | Repo path     |
| ------------------- | ------------- |
| `~/.config/nvim/*`  | `nvim/*`      |
| `~/.p10k.zsh`       | `p10k.zsh`    |
| `~/.zshrc`                | `zsh/zshrc`   |
| `~/.zshenv`               | `zsh/zshenv`  |
| `~/.config/ghostty/config` | `ghostty/config` |
| `~/.config/lazygit/config.yml` | `lazygit/config.yml` |
| `~/.config/gh/config.yml`  | `gh/config.yml` |
| `~/.gitconfig`            | `git/config` (partial) |
| `~/.config/bat/config`          | `bat/config` |
| `~/.config/ripgrep/config`     | `ripgrep/config` |
| `~/.config/fd/ignore`          | `fd/ignore` |
| `~/.config/yazi/yazi.toml`     | `yazi/yazi.toml` |
