### Add themes
```
cd ~/.config/alacritty
```
```
git clone https://github.com/alacritty/alacritty-theme themes
```

### Config alacritty
```
mkdir -p ~/.config/alacritty
```
```
cd ~/.config/alacritty
```
```
cd ~/.config/alacritty
```
```
nano alacritty.toml
```
or
```
code alacritty.toml
```


```
import = [
    "~/.config/alacritty/themes/themes/dracula.toml"
]
[env]
TERM = "xterm-256color"

[window]
padding.x = 10
padding.y = 10

[font]
normal.family = "JetBrainsMono Nerd Font"

size = 13

```

### Better zsh history completion with up, down arrows

- Open ~/.zshrc
```
# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
```

