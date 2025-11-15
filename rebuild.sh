#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/nixos"
NIXOS_LOG_FILE="$CONFIG_DIR/rebuild.log"

TARGET=""
UPDATE_FLAKES=false
VERBOSE=false
PUSH=true

Help()
{
    # Display Help
    echo "NixOS rebuild script."
    echo
    echo "Syntax: $0 -t <target> [-u] [-v] [--no-push]"
    echo "options:"
    echo "t     Build target: what target the system should build to."
    echo "u     Update flakes: updates the flakes in nix configuration."
    echo "v     Verbose output: show build logs in the terminal."
    echo "--no-push  Do not push changes to the repository."
    echo
}

TEMP=$(getopt -o t:uv --long no-push -n "$0" -- "$@")
if [ $? != 0 ]; then
    echo "Error in arguments" >&2
    Help
    exit 1
fi
eval set -- "$TEMP"

while true; do
  case "$1" in
    -t)
      TARGET="$2"
      shift 2
      ;;
    -u)
      UPDATE_FLAKES=true
      shift
      ;;
    -v)
      VERBOSE=true
      shift
      ;;
    --no-push)
      PUSH=false
      shift
      ;;
    --)
      shift
      break
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

if $VERBOSE; then
    sudo nixos-rebuild switch --upgrade --flake "$CONFIG_DIR#$TARGET" --accept-flake-config --option cores 4 2>&1 | tee "$NIXOS_LOG_FILE"
    REBUILD_EXIT_STATUS=${PIPESTATUS[0]}
else
    sudo nixos-rebuild switch --upgrade --flake "$CONFIG_DIR#$TARGET" --accept-flake-config --option cores 4 &> "$NIXOS_LOG_FILE"
    REBUILD_EXIT_STATUS=$?
fi

if [ $REBUILD_EXIT_STATUS -ne 0 ]; then
    echo "Rebuild failed. "
    if ! $VERBOSE; then
        echo "Showing errors:"
        grep --color -i -A3 "error" "$NIXOS_LOG_FILE" || cat "$NIXOS_LOG_FILE"
    fi
    exit 1
else
    echo "Rebuild successful!"
fi

if ! git diff --quiet; then
    gen=$(nixos-rebuild list-generations | awk '/Generation/{getline; print $1}')
    git commit -am "NixOS Generation: $TARGET $gen"
    if [ "$PUSH" = true ]; then
        git push
        echo "Changes pushed!"
    else
        echo "Changes commited but not pushed."
    fi
else
    echo "No changes to commit."
fi

popd > /dev/null
