#!/bin/bash
#  _      ______ ____  __  __ _____ _   _
# | |    |  ____/ __ \|  \/  |_   _| \ | |
# | |    | |__ | |  | | \  / | | | |  \| |
# | |    |  __|| |  | | |\/| | | | | . ` |
# | |____| |___| |__| | |  | |_| |_| |\  |
# |______|______\____/|_|  |_|_____|_| \_|

set -e  # Dừng nếu có lỗi

echo "🚀 Bắt đầu thiết lập môi trường phát triển macOS..."

# Hàm check và cài CLI tool nếu chưa có
install_cli() {
  if ! brew list "$1" &>/dev/null; then
    echo "🔧 Cài đặt $1..."
    brew install "$1"
  else
    echo "✅ Đã có $1 (bỏ qua)"
  fi
}

# Hàm check và cài GUI app nếu chưa có
install_cask() {
  if ! brew list --cask "$1" &>/dev/null; then
    echo "🖥️  Cài đặt $1..."
    brew install --cask "$1"
  else
    echo "✅ Đã có $1 (bỏ qua)"
  fi
}

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Cài đặt Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Đã có Homebrew (bỏ qua)"
fi

# 2. CLI tools
for tool in node python git ffmpeg python-tk stow starship fish MonitorControl; do
  install_cli "$tool"
done

# 3. GUI apps
casks=(
  alacritty font-jetbrains-mono-nerd-font brave-browser google-chrome
  postman dbeaver-community mongodb-compass visual-studio-code
  evkey cloudflare-warp karabiner-elements stats
  openinterminal-lite openineditor-lite dotnet-sdk docker balenaetcher
  iina notion keka telegram-desktop stremio mos easydict kitty
)

for app in "${casks[@]}"; do
  install_cask "$app"
done

# 4. Đặt Alacritty là terminal mặc định cho OpenInTerminal
defaults write wang.jianing.app.OpenInTerminal-Lite LiteDefaultTerminal Alacritty

# 5. QuickRecorder từ tap
if ! brew list quickrecorder &>/dev/null; then
  brew install lihaoyun6/tap/quickrecorder
else
  echo "✅ Đã có quickrecorder (bỏ qua)"
fi

# 6. Fish shell + plugins
FISH_PATH="$(which fish)"
if ! grep -q "$FISH_PATH" /etc/shells; then
  echo "🐟 Thêm Fish vào /etc/shells..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$FISH_PATH" ]; then
  echo "🐟 Đặt Fish làm shell mặc định..."
  chsh -s "$FISH_PATH"
fi

if ! fish -c "functions -q fisher"; then
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fi

# Plugin list
plugins=(gazorby/fish-abbreviation-tips jhillyerd/plugin-git jethrokuan/z jorgebucaran/autopair.fish)
for plugin in "${plugins[@]}"; do
  fish -c "fisher list | grep -q '$plugin' || fisher install $plugin"
done

# 7. Dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📁 Clone dotfiles..."
  git clone https://github.com/Leomin07/dotfiles.git "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR" && stow .

# 8. Git & SSH
git config --global user.name "MinhTD"
git config --global user.email "tranminhsvp@gmail.com"

SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
  ssh-keygen -t ed25519 -C "tranminhsvp@gmail.com" -f "$SSH_KEY" -N ""
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain "$SSH_KEY"
  pbcopy < "$SSH_KEY.pub"
  echo "✅ SSH key đã copy vào clipboard. Dán lên GitHub: https://github.com/settings/keys"
else
  echo "✅ SSH key đã tồn tại (bỏ qua)"
fi

echo "🎉 Thiết lập hoàn tất!"
