#!/bin/bash
set -euo pipefail

NC='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'

echo -e "${BLUE}==> Setting up user shell...${NC}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${GREEN}Oh-My-Zsh is already installed.${NC}"
fi

if command -v zsh &> /dev/null; then
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo "Changing default shell to zsh..."
        sudo chsh -s "$(which zsh)" "$USER"
    else
        echo -e "${GREEN}Zsh is already set as default shell.${NC}"
    fi
else
    echo "Zsh is not installed. Skipping shell change."
fi
