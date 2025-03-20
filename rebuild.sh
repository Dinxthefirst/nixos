#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/nixos"
NIXOS_LOG_FILE="$CONFIG_DIR/nixos-switch.log"
GIT_LOG_FILE="$CONFIG_DIR/git.log"

git_log() {
    echo "> git $*" >> "$GIT_LOG_FILE"
    git "$@" &>> "$GIT_LOG_FILE"
}

pushd "$CONFIG_DIR" > /dev/null

git_log diff -U0 --color=always *.nix || true

git_log ls-files --others --exclude-standard | xargs -r -I {} git_log add {}

echo "NixOS Rebuilding..."
if sudo nixos-rebuild switch --upgrade --flake "$CONFIG_DIR#desktop" --option cores 4 &> "$NIXOS_LOG_FILE"; then
    echo "Rebuild successful!"
else
    echo "Rebuild failed. Showing errors:"
    grep --color -i -A3 "error" "$NIXOS_LOG_FILE" || cat "$NIXOS_LOG_FILE"
    exit 1
fi

if ! git_log diff --quiet; then
    gen=$(nixos-rebuild list-generations | awk '/current/ {print $1}')
    git_log commit -am "NixOS Generation: $gen"
    git_log push
    echo "Changes pushed!"
else
    echo "No changes to commit."
fi

popd > /dev/null
