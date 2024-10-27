# Nix configs
## Installation
1. Clone repo
```sh
git clone git@github.com:spreadprism/nixdots.git $HOME/nixdots
```
2. (Optional) Install [Nix](https://nixos.org/download/)
3. Install flake

### NixOS
```sh
sudo nixos-rebuild switch --flake .#$HOST
```
### Darwin
```sh
darwin-rebuild switch --flake .
```
### Home-manager
```sh
nix run home-manager/master --extra-experimental-features 'nix-command flakes' -- switch --flake .#$(whoami)@$HOST --experimental-features 'nix-command flakes'
```
## Reload flake
### NixOS
```sh
sudo nixos-rebuild switch --flake .
```
### Home-manager
```sh
home-manager switch --flake .
```
