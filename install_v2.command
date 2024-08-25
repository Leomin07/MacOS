/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
npm i -g yarn
brew install python
brew install git
brew install --cask alacritty
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask brave-browser
brew install --cask google-chrome
brew install --cask postman
brew install --cask dbeaver-community
brew install --cask mongodb-compass
brew install --cask visual-studio-code
brew install --cask evkey
brew install --cask cloudflare-warp
brew install --cask karabiner-elements
brew install ffmpeg
brew install --cask stats
brew install python-tk
brew install --cask openinterminal-lite
brew install --cask openineditor-lite
defaults write wang.jianing.app.OpenInTerminal-Lite LiteDefaultTerminal Alacritty
brew install --cask dotnet-sdk
brew install --cask docker
brew install --cask balenaetcher
brew install --cask iina
brew install --cask notion
brew install --cask the-unarchiver
brew install --cask telegram-desktop
brew install --cask stremio
brew install starship
brew install fish
brew install --cask mos
brew install --cask easydict


curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install gazorby/fish-abbreviation-tips
fisher install jhillyerd/plugin-git
fisher install jethrokuan/z
fisher install jorgebucaran/autopair.fish