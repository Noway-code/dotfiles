#!/bin/bash

# -------------------------------------------------------------------
# Script Name: setup_dotfiles.sh
# Description: Automates moving of ~/.config/<package> to
#              ~/Git/Dotfiles/<package> and creates symlinks.
# Usage: ./setup_dotfiles.sh <package1> [<package2> ...]
# -------------------------------------------------------------------

set -e  # Exit immediately if a command exits with a non-zero status

# Function to display usage information
usage() {
    echo "Usage: $0 <package1> [<package2> ...]"
    echo "Example: $0 nvim alacritty zsh"
    exit 1
}

# Check if at least one package name is provided
if [ $# -lt 1 ]; then
    echo "Error: No package names provided."
    usage
fi

# Define base directories
DOTFILES_DIR="$HOME/Git/dotfiles/archenvy"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Iterate over all provided package names
for PACKAGE in "$@"; do
    echo "----------------------------------------"
    echo "Processing package: $PACKAGE"

    SOURCE="$CONFIG_DIR/$PACKAGE"
    TARGET="$DOTFILES_DIR/$PACKAGE"

    # Check if the source exists
    if [ ! -e "$SOURCE" ] && [ ! -L "$SOURCE" ]; then
        echo "Warning: Source '$SOURCE' does not exist. Skipping."
        continue
    fi

    # If target already exists in dotfiles, skip or handle accordingly
    if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
        echo "Warning: Target '$TARGET' already exists in dotfiles. Skipping to avoid overwriting."
        continue
    fi

    # If source is a symlink, remove it before moving
    if [ -L "$SOURCE" ]; then
        echo "Removing existing symlink '$SOURCE'."
        rm "$SOURCE"
    elif [ -e "$SOURCE" ]; then
        echo "Backing up existing '$SOURCE' to '$BACKUP_DIR/'."
        mv "$SOURCE" "$BACKUP_DIR/"
    fi

    # Ensure the target directory exists
    mkdir -p "$(dirname "$TARGET")"

    # Move the source to the dotfiles directory
    mv "$BACKUP_DIR/$PACKAGE" "$TARGET" 2>/dev/null || echo "Moved '$SOURCE' to '$TARGET'."

    # Create the symlink from .config to dotfiles
    ln -s "$TARGET" "$SOURCE"
    echo "Symlink created: '$SOURCE' -> '$TARGET'"

done

echo "----------------------------------------"
echo "Dotfiles setup completed successfully."


