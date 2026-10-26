# davic's dotfiles

Personal dotfiles, consumed by [dev-setup](https://github.com/davichuder/dev-setup)
through its `mise.dotfiles.toml` module (clone into `~/dotfiles`, then map files).

## Layout

```
nvim/        LazyVim starter (mapped to ~/.config/nvim)
```

## Mappings

| Live path           | Repo path    |
| ------------------- | ------------ |
| `~/.config/nvim/*`  | `nvim/*`     |

## Applying

Wires to `dev-setup`'s `mise.dotfiles.toml` (`[bootstrap.repos]` +
`[dotfiles]` entries per file). See that repository's README for the
`./bootstrap.sh <module> --dotfiles` flow.
