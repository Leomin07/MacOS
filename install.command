/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
npm i -g yarn
brew install python@3.12
brew install git
brew install --cask google-chrome
brew install --cask archiver
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
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
