#!/bin/bash

# Check if fzf is installed
if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Install with 'brew install fzf'."
    exit 1
fi

# Get list of installed formulae and casks, combine and use fzf for selection
package=$( { brew list 2>/dev/null | awk -F' ' '{print $1}' ; brew list --cask 2>/dev/null | awk -F' ' '{print $1}' ; } | sort -u | fzf --height 40% --layout reverse --border --prompt="Select package or cask to remove: ")

# Exit if no package selected or command failed
if [ -z "$package" ]; then
    echo "No package or cask selected or command failed. Exiting."
    exit 0
fi

# Confirm removal
echo "Are you sure you want to remove '$package'? [Y/n]"
read -r confirmation
if [[ "$confirmation" =~ ^[Nn]$ ]]; then
    echo "Removal cancelled."
    exit 0
fi

# Remove the selected package or cask
echo "Removing $package..."
if brew list "$package" >/dev/null 2>&1; then
    # It's a formula
    if ! brew uninstall "$package"; then
        echo "Error: Failed to remove formula $package."
    fi
elif brew list --cask "$package" >/dev/null 2>&1; then
    # It's a cask
    if ! brew uninstall --cask "$package"; then
        echo "Error: Failed to remove cask $package."
    fi
else
    echo "Error: Package '$package' not found in installed formulae or casks."
fi
