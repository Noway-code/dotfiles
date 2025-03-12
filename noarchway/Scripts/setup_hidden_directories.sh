#!/bin/bash

# -------------------------------------------------------------------
# Script Name: setup_hidden_dotdirs.sh
# Description: Automates moving of hidden directories (e.g. ~/.oh_my_zsh, ~/.poshthemes)
#              from the home directory to ~/Git/dotfiles/noarchway and creates symlinks.
# Usage: ./setup_hidden_dotdirs.sh <dir1> [<dir2> ...]
# -------------------------------------------------------------------

set -e  # Exit immediately if a command exits with a non-zero status

# Function to display usage information
usage() {
    echo "Usage: $0 <dir1> [<dir2> ...]"
    echo "Example: $0 .oh_my_zsh .poshthemes"
    exit 1
}

# Check if at least one directory is provided
if [ $# -lt 1 ]; then
    echo "Error: No hidden directories provided."
    usage
fi

# Define base directories
DOTFILES_DIR="$HOME/Git/dotfiles/noarchway"
HOME_DIR="$HOME"
BACKUP_DIR="$HOME/dotdirs_backup"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Iterate over all provided directory names
for DIR in "$@"; do
    echo "----------------------------------------"
    echo "Processing hidden directory: $DIR"

    SOURCE="$DIR"
    TARGET="$DOTFILES_DIR/$DIR"

    # Check if the source exists
    if [ ! -e "$SOURCE" ] && [ ! -L "$SOURCE" ]; then
        echo "Warning: Source '$SOURCE' does not exist. Skipping."
        continue
    fi

    # If target already exists in dotfiles, skip to avoid overwriting
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

    # Move the source directory to the dotfiles directory
    mv "$BACKUP_DIR/$DIR" "$TARGET" 2>/dev/null || echo "Moved '$SOURCE' to '$TARGET'."

    # Create the symlink from home directory to dotfiles
    ln -s "$TARGET" "$SOURCE"
    echo "Symlink created: '$SOURCE' -> '$TARGET'"
done

echo "----------------------------------------"
echo "Hidden dotdirectories setup completed successfully."

