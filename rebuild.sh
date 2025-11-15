#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/nixos"
NIXOS_LOG_FILE="$CONFIG_DIR/rebuild.log"

TARGET=""
UPDATE_FLAKES=false

Help()
{
   # Display Help
   echo "NixOS rebuild script."
   echo
   echo "Syntax: $0 -t <target> [-u]"
   echo "options:"
   echo "t     The target that the system should build to."
   echo "u     If the rebuild should update the flakes."
   echo
}

while getopts "t:u" opt; do
  case $opt in
    t)
      TARGET="$OPTARG"
      ;;
    u)
      UPDATE_FLAKES=true
      ;;
    *)
      Help
      exit 1
      ;;
  esac
done

if [ -z "$TARGET" ]; then
  echo "Error: Target (-t) is required."
  Help
  exit 1
fi

pushd "$CONFIG_DIR" > /dev/null

git stash push -u -m "Auto-stash before rebase"
git pull --rebase
git stash pop || true

git diff -U0 --color=always *.nix || true

git ls-files --others --exclude-standard | xargs -r git add

if [ "$UPDATE_FLAKES" = true ]; then
    echo "Updating flake inputs..."
    nix flake update --accept-flake-config > /dev/null
fi

echo "NixOS Rebuilding for $TARGET..."
if sudo nixos-rebuild switch --upgrade --flake "$CONFIG_DIR#$TARGET" --accept-flake-config --option cores 4 &> "$NIXOS_LOG_FILE"; then
    echo "Rebuild successful!"
else
    echo "Rebuild failed. Showing errors:"
    grep --color -i -A3 "error" "$NIXOS_LOG_FILE" || cat "$NIXOS_LOG_FILE"
    exit 1
fi

if ! git diff --quiet; then
    gen=$(nixos-rebuild list-generations | awk '/Generation/{getline; print $1}')
    git commit -am "NixOS Generation: $TARGET $gen"
    git push
    echo "Changes pushed!"
else
    echo "No changes to commit."
fi

popd > /dev/null
