#!/bin/sh

DIR=$(dirname "$0")
DIR_NAME=$(basename "$DIR")
PARENT_DIR=$(dirname "$DIR")

stow -t ~/.config -d "$PARENT_DIR" --override=".*" --no-folding "$DIR_NAME"
