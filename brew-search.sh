#!/bin/bash

# Check if fzf is installed
if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Install with 'brew install fzf'."
    exit 1
fi

# Get list of available formulae and casks, combine and use fzf for selection
package=$( { brew formulae 2>/dev/null | awk -F' ' '{print $1}' ; brew casks 2>/dev/null | awk -F' ' '{print $1}' ; } | sort -u | fzf --height 40% --layout reverse --border --prompt="Select package or cask to install: ")

# Exit if no package selected or command failed
if [ -z "$package" ]; then
    echo "No package or cask selected or command failed. Exiting."
    exit 0
fi

# Check if package/cask is already installed
if brew list "$package" >/dev/null 2>&1 || brew list --cask "$package" >/dev/null 2>&1; then
    echo "Package or cask '$package' is already installed!"
    echo "Use 'brew info $package' for more details or 'brew upgrade $package' to update."
else
    # Install the selected package or cask
    echo "Installing $package..."
    if ! (brew install "$package" || brew install --cask "$package"); then
        echo "Error: Failed to install $package."
    fi
fi
