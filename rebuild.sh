#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${NIXOS_CONFIG_DIR:-$HOME/.config/nixos}"
NIXOS_LOG_FILE="$CONFIG_DIR/rebuild.log"

die() { echo "error: $*" >&2; exit 1; }

usage() {
    cat <<EOF
Usage: $(basename "$0") <target> [-h] [-u] [-v] [-b] [--no-push]

Options:
  -h, --help      Show this help
  -u, --update    Update flake inputs before rebuilding
  -v, --verbose   Stream build logs to terminal
  -b, --boot      Use 'nixos-rebuild boot' instead of 'switch'
      --no-push   Commit but do not push
EOF
}

[[ $# -eq 0 ]] && { usage; exit 1; }

TARGET="$1"; shift

UPDATE_FLAKES=false
VERBOSE=false
PUSH=true
BOOT=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)     usage; exit 0 ;;
        -u|--update)   UPDATE_FLAKES=true ;;
        -v|--verbose)  VERBOSE=true ;;
        -b|--boot)     BOOT=true ;;
        --no-push)     PUSH=false ;;
        -*) die "unknown option: $1" ;;
        *)  die "unexpected argument: $1" ;;
    esac
    shift
done

[[ -d "$CONFIG_DIR" ]] || die "config dir not found: $CONFIG_DIR"

pushd "$CONFIG_DIR" > /dev/null
trap 'popd > /dev/null' EXIT

git pull --rebase --autostash

git diff -U0 --color=always -- '*.nix' || true

if [[ "$UPDATE_FLAKES" == true ]]; then
    echo "Updating flake inputs..."
    nix flake update --accept-flake-config
fi

REBUILD_CMD="nixos-rebuild $( $BOOT && echo boot || echo switch )"
REBUILD_CMD+=" --flake ${CONFIG_DIR}#${TARGET} --accept-flake-config --sudo"

echo "NixOS Rebuilding for $TARGET..."

if [[ "$VERBOSE" == true ]]; then
    $REBUILD_CMD 2>&1 | tee "$NIXOS_LOG_FILE"
    REBUILD_EXIT_STATUS=${PIPESTATUS[0]}
else
    $REBUILD_CMD &> "$NIXOS_LOG_FILE"
    REBUILD_EXIT_STATUS=$?
fi

if [[ $REBUILD_EXIT_STATUS -ne 0 ]]; then
    echo "Rebuild failed." >&2
    if [[ "$VERBOSE" != true ]]; then
        echo "--- Errors ---" >&2
        grep --color=always -i -A3 "error" "$NIXOS_LOG_FILE" \
            || cat "$NIXOS_LOG_FILE"
    fi
    exit "$REBUILD_EXIT_STATUS"
fi
 
echo "Rebuild successful!"

git add -A

if ! git diff --cached --quiet; then
    gen=$(nixos-rebuild list-generations | awk 'NR>1 && /True/{print $1}')
    git commit -m "nixos: ${TARGET} generation ${gen}"

    if [[ "$PUSH" == true ]]; then
        git push
        echo "Changes pushed!"
    else
        echo "Commited, not pushed."
    fi
else
    echo "No changes to commit."
    if [[ "$PUSH" == true ]] \
        && git rev-list HEAD@{upstream}..HEAD 2>/dev/null | grep -q .; then
        git push
        echo "Pushed existing unpushed commits."
    fi
fi
