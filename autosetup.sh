#!/bin/bash
#  _       ______ ____  __  __ _____ _   _
# | |     |  ____/ __ \|   \/   |_   _| \ | |
# | |     | |__ | |  | |  \  /   | | |  \| |
# | |     |  __|| |  | |  |\/    | | | . ` |
# | |____ | |___| |__| |  |  |   | | | |\  |
# |______|______\____/|_|  |_|   |_| |_| \_|

set -euo pipefail # Exit on errors, unset vars, and pipe failures

LOG_FILE="$HOME/setup.log"
LOG_DATE=$(date +'%Y-%m-%d %H:%M:%S')

log() {
  echo "$LOG_DATE - $1" | tee -a "$LOG_FILE"
}

error_exit() {
  log "❌ ERROR: $1"
  exit 1
}

log_warning() {
  log "⚠️ WARNING: $1"
}

# Unified install function
install_package() {
  local type="$1"
  local package="$2"
  local cmd

  case "$type" in
  cli) cmd="brew install" ;;
  cask) cmd="brew install --cask" ;;
  *) error_exit "Invalid package type: $type" ;;
  esac

  if ! brew list ${type}s "$package" &>/dev/null; then
    log "🔧 Installing $type: $package..."
    brew update # Update brew before installing
    if ! $cmd "$package"; then
      error_exit "Failed to install $type: $package"
    fi
  else
    log "✅ $type: $package already installed (skipping)"
  fi
}

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  log "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error_exit "Homebrew installation failed"
else
  log "✅ Homebrew already installed (skipping)"
fi

# 2. CLI tools
cli_tools=(node python git ffmpeg python-tk stow starship fish MonitorControl)
for tool in "${cli_tools[@]}"; do
  install_package "cli" "$tool"
done

# 3. GUI apps
cask_apps=(
  alacritty font-jetbrains-mono-nerd-font brave-browser google-chrome
  postman dbeaver-community mongodb-compass visual-studio-code
  evkey cloudflare-warp karabiner-elements stats
  openinterminal-lite openineditor-lite dotnet-sdk docker balenaetcher
  iina notion keka telegram-desktop stremio mos easydict
)

for app in "${cask_apps[@]}"; do
  install_package "cask" "$app"
done

# 4. Đặt Alacritty là terminal mặc định cho OpenInTerminal
log "⚙️ Setting Alacritty as default terminal for OpenInTerminal..."
defaults write wang.jianing.app.OpenInTerminal-Lite LiteDefaultTerminal Alacritty

# 5. QuickRecorder từ tap
if ! brew list quickrecorder &>/dev/null; then
  log "🔧 Installing QuickRecorder from tap..."
  brew tap lihaoyun6/tap
  brew install lihaoyun6/tap/quickrecorder || error_exit "Failed to install QuickRecorder"
else
  log "✅ QuickRecorder already installed (skipping)"
fi

# 6. Fish shell + plugins
configure_fish() {
  local fish_path="$(which fish)"

  # Add Fish to /etc/shells if not already present
  if ! grep -q "$fish_path" /etc/shells; then
    log "🐟 Adding Fish to /etc/shells..."
    echo "$fish_path" | sudo tee -a /etc/shells || error_exit "Failed to add Fish to /etc/shells"
  fi

  # Change default shell to Fish if not already
  if [ "$SHELL" != "$fish_path" ]; then
    log "🐟 Setting Fish as default shell..."
    chsh -s "$fish_path" || error_exit "Failed to set Fish as default shell. You may need to restart your terminal."
  else
    log "✅ Fish is already the default shell (skipping)"
  fi

  # Install Fisher and plugins only if Fish config is not already set
  # This is a simplified check; you might need more specific checks if needed
  if [ ! -f "$HOME/.config/fish/config.fish" ]; then
    # Install Fisher if not present
    if ! fish -c "functions -q fisher"; then
      log "🎣 Installing Fisher..."
      fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher' || error_exit "Fisher installation failed"
    else
      log "✅ Fisher already installed (skipping)"
    fi

    # Install Fish plugins
    local plugins=(
      gazorby/fish-abbreviation-tips
      jhillyerd/plugin-git
      jethrokuan/z
      jorgebucaran/autopair.fish
    )
    for plugin in "${plugins[@]}"; do
      if ! fish -c "fisher list | grep -q '$plugin'"; then
        log "🔌 Installing Fish plugin: $plugin..."
        fish -c "fisher install $plugin" || error_exit "Failed to install Fish plugin: $plugin"
      else
        log "✅ Fish plugin: $plugin already installed (skipping)"
      fi
    done
  else
    log "✅ Fish configuration already exists (skipping)"
  fi
}

configure_fish

# 7. Dotfiles
configure_dotfiles() {
  local dotfiles_dir="$HOME/.dotfiles"

  # Clone dotfiles if not present
  if [ ! -d "$dotfiles_dir" ]; then
    log "📁 Cloning dotfiles..."
    git clone https://github.com/Leomin07/dotfiles.git "$dotfiles_dir" || error_exit "Failed to clone dotfiles"
  else
    log "✅ Dotfiles directory already exists (skipping clone)"
  fi

  # Stow dotfiles
  log "📦 Stowing dotfiles..."
  cd "$dotfiles_dir" || error_exit "Failed to change directory to dotfiles"
  stow . || error_exit "Failed to stow dotfiles"

  # Reload Alacritty configuration
  log "🔄 Reloading Alacritty configuration..."
  if pgrep -x "Alacritty" >/dev/null; then
    osascript -e 'tell application "Alacritty" to activate' -e 'tell application "System Events" to keystroke "r" using {command down}' || log_warning "Failed to reload Alacritty configuration. Please reload it manually (Cmd+R)."
  else
    log "⚠️ Alacritty is not running. Skipping reload."
  fi
}

configure_dotfiles

# 8. Git & SSH
configure_git_ssh() {
  log "⚙️ Configuring Git..."

  # Check if Git config is already set
  local git_name=$(git config --global user.name)
  local git_email=$(git config --global user.email)

  if [ -z "$git_name" ] || [ -z "$git_email" ]; then
    git config --global user.name "MinhTD"
    git config --global user.email "tranminhsvp@gmail.com"
  else
    log "✅ Git user configuration already exists (skipping)"
  fi

  local ssh_key="$HOME/.ssh/id_ed25519"
  local public_key="${ssh_key}.pub"

  # Generate SSH key if not present
  if [ ! -f "$ssh_key" ]; then
    log "🔑 Generating SSH key..."
    ssh-keygen -t ed25519 -C "tranminhsvp@gmail.com" -f "$ssh_key" -N "" || error_exit "SSH key generation failed"
    eval "$(ssh-agent -s)" || error_exit "Failed to start ssh-agent"
    ssh-add --apple-use-keychain "$ssh_key" || error_exit "Failed to add SSH key to keychain"
    if command -v pbcopy &>/dev/null; then
      pbcopy <"$public_key"
      log "✅ SSH public key copied to clipboard. You can now paste it (e.g., on GitHub: https://github.com/settings/keys)"
    else
      log_warning "Command 'pbcopy' not found. Please copy the public key manually from: $public_key"
    fi
    log "🔑 SSH key generated at: $ssh_key"
  else
    log "✅ SSH key already exists (skipping generation)"
  fi
}

configure_git_ssh

# 9. Configure Dock autohide delay
configure_dock() {
  log "⚙️ Configuring Dock..."

  local current_delay=$(defaults read com.apple.dock autohide-delay 2>/dev/null)

  if [ "$current_delay" != "0" ]; then
    defaults write com.apple.dock autohide-delay -float 0
    killall Dock || log_warning "Failed to restart Dock. You may need to do it manually."
  else
    log "✅ Dock autohide delay already set to 0 (skipping)"
  fi
}

configure_dock

log "🎉 Thiết lập hoàn tất!"
