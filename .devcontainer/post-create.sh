#!/usr/bin/env bash

# Install dependencies
sudo apt-get update && sudo apt-get install -y \
    bash \
    curl \
    git \
    zsh

# Install nvm (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Install Node.js and npm
if command -v nvm &>/dev/null; then
  nvm install --lts
  nvm install-latest-npm
fi

# Install npm dependencies (if package.json exists)
if [ -f package.json ]; then
  npm install
  npm run build
fi

# Install shfmt
curl -sS https://webi.sh/shfmt | sh &>/dev/null

# Install Oh My Zsh plugins (if Oh My Zsh is installed)
if [ -d "$HOME/.oh-my-zsh" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  sed -i -E "s/^(plugins=\()(git)(\))/\1\2 zsh-syntax-highlighting zsh-autosuggestions\3/" ~/.zshrc
fi

# Disable less for git log
echo -e "\nunset LESS" >>~/.zshrc

echo "Post-create script completed."