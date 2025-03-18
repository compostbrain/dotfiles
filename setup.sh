#!/usr/bin/env bash
set -e

########################################
# 1. Install Homebrew (if not installed)
########################################
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

########################################
# 2. Install Essential CLI Tools and Utilities
########################################
echo "Installing essential CLI tools..."
tools=(
  gh           # GitHub CLI
  git          # Git version control
  tldr         # Simplified man pages
  tree         # Directory tree viewer
  wget         # Internet file retriever
  jq           # JSON processor
  redis        # In-memory data structure store
  postgresql@14 # PostgreSQL database
  mysql        # MySQL database
  memcached    # Memory object caching system
  direnv       # Environment variable manager
  overmind     # Process manager for Procfile-based applications
  imagemagick  # Image processing
  httpie       # HTTP client
  bat          # Syntax highlighting cat
  exa          # Modern ls
  fd           # Modern find
  fzf          # Fuzzy finder
  ripgrep      # Line-oriented search tool
  shellcheck   # Shell script analysis tool
  )

for tool in "${tools[@]}"; do
  if ! brew ls --versions "$tool" &>/dev/null; then
    echo "Installing $tool..."
    brew install "$tool"
  else
    echo "$tool is already installed."
  fi
done

########################################
# 3. Install Desktop Apps via Homebrew Cask
########################################
echo "Installing Desktop Apps..."

# Docker Desktop (launch manually after installation)
if ! brew list --cask docker &>/dev/null; then
  echo "Installing Docker Desktop..."
  brew install --cask docker
fi

# Visual Studio Code & VSCode Insiders
if ! brew list --cask visual-studio-code &>/dev/null; then
  echo "Installing Visual Studio Code..."
  brew install --cask visual-studio-code
fi

if ! brew list --cask visual-studio-code-insiders &>/dev/null; then
  echo "Installing VSCode Insiders..."
  brew install --cask visual-studio-code-insiders
fi

# ChatGPT Desktop App (unofficial; if available)
if ! brew list --cask chatgpt &>/dev/null; then
  echo "Installing ChatGPT Desktop (if available)..."
  brew install --cask chatgpt || echo "ChatGPT desktop not available via brew. Please install manually if desired."
fi

# Google Chrome
if ! brew list --cask google-chrome &>/dev/null; then
  echo "Installing Google Chrome..."
  brew install --cask google-chrome
fi

########################################
# 4. Install asdf via Homebrew and Setup zsh Autocomplete
########################################
if ! brew ls --versions asdf &>/dev/null; then
  echo "Installing asdf via Homebrew..."
  brew install asdf
fi

# Ensure asdf is initialized in zsh with autocompletion
ASDF_INIT_STRING=". \$(brew --prefix asdf)/asdf.sh"
ZSH_RC="$HOME/.zshrc"
if [ -n "$ZSH_VERSION" ]; then
  if ! grep -qF "$ASDF_INIT_STRING" "$ZSH_RC"; then
    echo -e "\n# asdf initialization" >> "$ZSH_RC"
    echo "$ASDF_INIT_STRING" >> "$ZSH_RC"
    echo "fpath=(\$(brew --prefix asdf)/completions \$fpath)" >> "$ZSH_RC"
  fi
fi
# Also source asdf for the current shell session
. "$(brew --prefix asdf)/asdf.sh"

########################################
# 5. Install and Configure Languages via asdf
########################################

## --- Ruby Setup ---
if ! asdf plugin-list | grep -q ruby; then
  echo "Adding Ruby plugin to asdf..."
  asdf plugin-add ruby
fi

# Set desired Ruby version (adjust as needed)
RUBY_VERSION="3.2.0"
if ! asdf list ruby | grep -q "$RUBY_VERSION"; then
  echo "Installing Ruby $RUBY_VERSION..."
  asdf install ruby "$RUBY_VERSION"
fi
asdf global ruby "$RUBY_VERSION"

# Install Rails gem
echo "Installing Rails gem..."
gem install rails

## --- Node.js Setup ---
if ! asdf plugin-list | grep -q nodejs; then
  echo "Adding Node.js plugin to asdf..."
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  # Import Node.js release team's OpenPGP keys (required per asdf guide)
  bash "$(brew --prefix asdf)/plugins/nodejs/bin/import-release-team-keyring"
fi

# Set desired Node.js version (using an LTS version)
NODE_VERSION="18.16.0"
if ! asdf list nodejs | grep -q "$NODE_VERSION"; then
  echo "Installing Node.js $NODE_VERSION..."
  asdf install nodejs "$NODE_VERSION"
fi
asdf global nodejs "$NODE_VERSION"

## --- Python Setup for Machine Learning ---
if ! asdf plugin-list | grep -q python; then
  echo "Adding Python plugin to asdf..."
  asdf plugin-add python
fi

# Set desired Python version
PYTHON_VERSION="3.10.10"
if ! asdf list python | grep -q "$PYTHON_VERSION"; then
  echo "Installing Python $PYTHON_VERSION..."
  asdf install python "$PYTHON_VERSION"
fi
asdf global python "$PYTHON_VERSION"

# Upgrade pip and install popular ML libraries
echo "Upgrading pip and installing Python ML libraries..."
python -m pip install --upgrade pip
python -m pip install numpy pandas scikit-learn jupyter matplotlib seaborn

########################################
# 6. Install VSCode Extensions for Development
########################################
# Check if the VSCode command-line tool is available
if command -v code &>/dev/null; then
  echo "Installing VSCode extensions for development..."
  vscode_extensions=(
    "GitHub.copilot"                    # GitHub Copilot
    "rebornix.ruby"                     # Ruby language support
    "wingrunr21.vscode-ruby"            # Ruby language support
    "castwide.solargraph"               # Ruby language server
    "kaiwood.endwise"                   # Automatically add 'end' in Ruby
    "aliariff.vscode-erb-beautify"      # ERB formatter
    "ms-azuretools.vscode-docker"       # Docker support
    "eamodio.gitlens"                   # Git integration
    "dbaeumer.vscode-eslint"            # ESLint
    "esbenp.prettier-vscode"            # Prettier code formatter
    "bradlc.vscode-tailwindcss"         # TailwindCSS support
    "mtxr.sqltools"                     # SQL tools
    "mtxr.sqltools-driver-pg"           # PostgreSQL driver for SQLTools
    "mtxr.sqltools-driver-mysql"        # MySQL driver for SQLTools
    "VisualStudioExptTeam.vscodeintellicode"  # AI-assisted development
    "chatgpt.chatgpt"                   # ChatGPT extension
  )

  for ext in "${vscode_extensions[@]}"; do
    code --install-extension "$ext" || echo "Failed to install $ext, continuing..."
  done
else
  echo "Warning: 'code' command not found in PATH. Please install the VSCode command-line tool for Visual Studio Code."
fi

# Check if the VSCode Insiders command-line tool is available
if command -v code-insiders &>/dev/null; then
  echo "Installing VSCode Insiders extensions for development..."
  vscode_insiders_extensions=(
    "GitHub.copilot"
    "rebornix.ruby"
    "wingrunr21.vscode-ruby"
    "castwide.solargraph"
    "kaiwood.endwise"
    "aliariff.vscode-erb-beautify"
    "ms-azuretools.vscode-docker"
    "eamodio.gitlens"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "bradlc.vscode-tailwindcss"
    "mtxr.sqltools"
    "mtxr.sqltools-driver-pg"
    "mtxr.sqltools-driver-mysql"
    "VisualStudioExptTeam.vscodeintellicode"
    "chatgpt.chatgpt"
  )

  for ext in "${vscode_insiders_extensions[@]}"; do
    code-insiders --install-extension "$ext" || echo "Failed to install $ext for VSCode Insiders, continuing..."
  done
else
  echo "Warning: 'code-insiders' command not found in PATH. Please install the VSCode Insiders command-line tool."
fi

########################################
# 7. Final Git Configuration Reminder
########################################
if [ ! -f "$HOME/.gitconfig" ]; then
  echo "Setting up Git global configuration..."
  git config --global user.name "Joel Cahalan"
  git config --global user.email "joelcahalan@gmail.com"
fi

########################################
# 8. Install and Configure iTerm2 and zsh
########################################
echo "Installing iTerm2 (a highly rated terminal for macOS)..."
if ! brew list --cask iterm2 &>/dev/null; then
  brew install --cask iterm2
fi

# Ensure zsh is the default shell (macOS uses zsh by default since Catalina)
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Setting zsh as the default shell..."
  chsh -s /bin/zsh
fi

# Install oh‑my‑zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh‑my‑zsh for enhanced zsh configuration..."
  # RUNZSH=no prevents immediate shell switch during installation.
  RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install recommended zsh plugins: autosuggestions and syntax-highlighting
ZSH_CUSTOM=${ZSH_CUSTOM:-"$HOME/.oh-my-zsh/custom"}
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

########################################
# 9. Additional Customizations: Hide the Dock Permanently
########################################
echo "Hiding the Dock permanently..."
# Enable auto‑hide for the Dock
defaults write com.apple.dock autohide -bool true
# Set an extremely long auto‑hide delay so the Dock remains hidden unless manually activated
defaults write com.apple.dock autohide-delay -float 9999
# Restart the Dock to apply changes
killall Dock

########################################
# Completion Message
########################################
echo "------------------------------------------------"
echo "Setup complete! Please launch Docker Desktop, iTerm2, and Chrome manually,"
echo "and restart your terminal to load asdf and zsh configurations properly."
echo "Happy coding!"