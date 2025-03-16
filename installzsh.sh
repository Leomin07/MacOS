#!/bin/bash
#  _      ______ ____  __  __ _____ _   _
# | |    |  ____/ __ \|  \/  |_   _| \ | |
# | |    | |__ | |  | | \  / | | | |  \| |
# | |    |  __|| |  | | |\/| | | | | . ` |
# | |____| |___| |__| | |  | |_| |_| |\  |
# |______|______\____/|_|  |_|_____|_| \_|

set -e

echo "💻 Bắt đầu cài đặt Oh My Zsh và plugin..."

# 1. Cài đặt Oh My Zsh nếu chưa có
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⚙️  Cài đặt Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ Đã có Oh My Zsh (bỏ qua)"
fi

# 2. Cài plugin
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
plugins=(
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-completions"
)

for plugin in "${plugins[@]}"; do
  name=$(basename "$plugin")
  dir="$ZSH_CUSTOM/plugins/$name"
  if [ ! -d "$dir" ]; then
    echo "🔌 Cài plugin $name..."
    git clone "https://github.com/$plugin" "$dir"
  else
    echo "✅ Đã có plugin $name (bỏ qua)"
  fi
done

# 3. Chỉnh .zshrc
ZSHRC="$HOME/.zshrc"

# Thay theme
sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$ZSHRC"

# Cập nhật plugins list
PLUGINS_LINE="plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting git aliases)"
if grep -q "^plugins=" "$ZSHRC"; then
  sed -i '' "s/^plugins=.*/$PLUGINS_LINE/" "$ZSHRC"
else
  echo "$PLUGINS_LINE" >> "$ZSHRC"
fi

echo "✅ Đã cấu hình theme và plugin trong .zshrc"

# Reload zsh config nếu đang dùng zsh
if [ "$SHELL" = "/bin/zsh" ]; then
  echo "🔄 Reload lại cấu hình Zsh..."
  source "$ZSHRC"
fi

echo "🎉 Hoàn tất cấu hình Oh My Zsh!"
