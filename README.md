# Nix configs
## Quick command
Reload home-manager flake
```sh
home-manager switch --flake .
```
## Install
1. Clone repo
```sh
git clone git@github.com:spreadprism/nixdots.git $HOME/nixdots
```
2. Install [Nix](https://nixos.org/download/)
3. Init home-manager
```sh
nix run home-manager/master --extra-experimental-features 'nix-command flakes' -- switch --flake .#$(whoami)@$HOST --experimental-features 'nix-command flakes'
```
