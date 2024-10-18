# Nix config

## Requirements
- [Nix](https://nixos.org/download/) Package manager

### Install Nix

#### Linux
Multi-user (Recommended) => If using systemd, with SELinux disabled and can auth with sudo
```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```
Single-user
```sh
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
#### MacOS
```sh
sh <(curl -L https://nixos.org/nix/install)
```

## How to use the flake

### NixOS
Installing
```sh
nixos-install --flake.#$HOST
```
Updating
```sh
nix flake update
nixos-rebuild switch --flake .#$HOST
```

### MacOS
<!-- TODO: -->

### Home-only
Installing
```sh
nix build .#$HOST
./result/activate
```
Updating
```sh
nix flake update
home-manager switch --flake .#$HOST
```
