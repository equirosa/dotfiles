# Kiri's Dotfiles

## Goals

- Managed by nix wherever possible.
  - **IMPORTANT:** This is done mostly as an exercise in my mastery of Nix, not necessarily because I think it's the way dotfiles *"should"* be managed.

## Useful Docs

Some useful documentation for the tools I'm using in this repo.
- [Nix Devdocs](https://devdocs.io/nix/)
- https://nix.dev

## Other great configs

If you're looking at this repo looking for inspiration, then consider taking a look at these others:

### Firefox

The `user.js` (`programs.firefox.settings` in the `firefox.nix` file) has plenty of settings borrowed from [arkenfox](https://github.com/arkenfox/user.js).

### Nix

- [Davidak's NixOS Config](https://codeberg.org/davidak/nixos-config)
- [David Armstrong's Nix Config](https://github.com/davidarmstronglewis/nix-config)
- [donovanglover's config](https://github.com/donovanglover/dotfiles).
  -  ~~Specifically the part about using `home-manager.sharedModules` to use `home-manager` inside the `nixosModule` 😅.~~ I no longer do it this way, but it's still a valid alternative 😁.
- [Mic92's](https://github.com/Mic92/dotfiles)
- [viperML's config](https://github.com/viperML/dotfiles)

### Neovim

My Neovim config is originally derived from the starter for [LazyVim](https://www.lazyvim.org/)

### Misc

- [Drew Devault's dotfile repo](https://git.sr.ht/~sircmpwn/dotfiles)
