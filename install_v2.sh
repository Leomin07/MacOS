/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
npm i -g yarn
brew install python
brew install git
brew install --cask alacritty
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask brave-browser
brew install --cask keka
brew install --cask google-chrome
brew install --cask postman
brew install --cask dbeaver-community
brew install --cask mongodb-compass
brew install --cask visual-studio-code
brew install --cask telegram-desktop
brew install --cask evkey
brew install --cask cloudflare-warp
brew install --cask karabiner-elements
brew install ffmpeg
brew install --cask stats
brew install python-tk
brew install --cask openinterminal-lite
brew install --cask openineditor-lite
defaults write wang.jianing.app.OpenInTerminal-Lite LiteDefaultTerminal Alacritty
brew install --cask notion
brew install --cask dotnet-sdk
brew install --cask docker
brew install --cask balenaetcher
brew install fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

sudo sh -c 'echo /usr/local/bin/fish >> /etc/shells'
chsh -s $(which fish)

omf install agnoster
