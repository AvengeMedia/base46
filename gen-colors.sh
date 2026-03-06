#!/usr/bin/env sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$SCRIPT_DIR/colors" ]; then
    mkdir -p "$SCRIPT_DIR/colors"
fi

for theme in "$SCRIPT_DIR"/lua/base46/themes/*.lua; do
    theme_name="$(basename "${theme%.*}")"
    cat >"$SCRIPT_DIR/colors/base46-$theme_name.lua" <<EOF
require("base46").load("$theme_name")
EOF
done
