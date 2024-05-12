/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
npm i -g yarn
brew install python
brew install git
brew install --cask brave-browser
brew install --cask keka
brew install --cask google-chrome
brew install --cask postman
brew install --cask dbeaver-community
brew install --cask mongodb-compass
brew install --cask visual-studio-code
brew install --cask telegram-desktop
brew install mysql
brew services start mysql
brew install redis
brew services start redis
brew install --cask gcollazo-mongodb
brew install --cask amd-power-gadget
brew install --cask evkey
brew install --cask cloudflare-warp
brew install --cask karabiner-elements
brew install MonitorControl
brew install ffmpeg
brew install --cask stats
brew install --cask openinterminal-lite
brew install --cask openineditor-lite
brew install --cask notion

brew install fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

sudo sh -c 'echo /usr/local/bin/fish >> /etc/shells'
chsh -s /usr/local/bin/fish

omf install agnoster
