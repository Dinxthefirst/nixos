#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/nixos"
NIXOS_LOG_FILE="$CONFIG_DIR/nixos-switch.log"
TARGET=$1

pushd "$CONFIG_DIR" > /dev/null

git stash push -u -m "Auto-stash before rebase"
git pull --rebase
git stash pop || true

git diff -U0 --color=always *.nix || true

git ls-files --others --exclude-standard | xargs -r git add

echo "Updating flake inputs..."
nix flake update --accept-flake-config

echo "NixOS Rebuilding for $TARGET..."
if sudo nixos-rebuild switch --upgrade --flake "$CONFIG_DIR#$TARGET" --accept-flake-config --option cores 4 &> "$NIXOS_LOG_FILE"; then
    echo "Rebuild successful!"
else
    echo "Rebuild failed. Showing errors:"
    grep --color -i -A3 "error" "$NIXOS_LOG_FILE" || cat "$NIXOS_LOG_FILE"
    exit 1
fi

if ! git diff --quiet; then
    gen=$(nixos-rebuild list-generations | awk '/current/ {print $1}')
    git commit -am "NixOS Generation: $gen"
    git push
    echo "Changes pushed!"
else
    echo "No changes to commit."
fi

popd > /dev/null
