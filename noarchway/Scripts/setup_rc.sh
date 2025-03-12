#!/bin/bash

# -------------------------------------------------------------------
# Script Name: setup_hidden_dotfiles.sh
# Description: Automates moving of dotfiles (e.g. .zshrc, .bashrc) from
#              the home directory to ~/Git/dotfiles/noarchway and creates symlinks.
# Usage: ./setup_hidden_dotfiles.sh <dotfile1> [<dotfile2> ...]
# -------------------------------------------------------------------

set -e  # Exit immediately if a command exits with a non-zero status

# Function to display usage information
usage() {
    echo "Usage: $0 <dotfile1> [<dotfile2> ...]"
    echo "Example: $0 .zshrc .bashrc .vimrc"
    exit 1
}

# Check if at least one dotfile is provided
if [ $# -lt 1 ]; then
    echo "Error: No dotfiles provided."
    usage
fi

# Define base directories
DOTFILES_DIR="$HOME/Git/dotfiles/noarchway"
HOME_DIR="$HOME"
BACKUP_DIR="$HOME/dotfiles_backup"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Iterate over all provided dotfile names
for FILE in "$@"; do
    echo "----------------------------------------"
    echo "Processing dotfile: $FILE"

    SOURCE="$HOME_DIR/$FILE"
    TARGET="$DOTFILES_DIR/$FILE"

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

    # Move the source file to the dotfiles directory
    mv "$BACKUP_DIR/$FILE" "$TARGET" 2>/dev/null || echo "Moved '$SOURCE' to '$TARGET'."

    # Create the symlink from home directory to dotfiles
    ln -s "$TARGET" "$SOURCE"
    echo "Symlink created: '$SOURCE' -> '$TARGET'"
done

echo "----------------------------------------"
echo "Hidden dotfiles setup completed successfully."

