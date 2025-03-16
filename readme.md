### Remove delay auto hidden dock
```
defaults write com.apple.dock autohide-delay -float 0;killall Dock
```
### Install theme agnoster

- Find location .oh-my-zsh: `home/.oh-my-zsh/themes`
- Replace file [theme](./agnoster.zsh-theme)
- Run command and successfully

```
AGNOSTER_PATH_STYLE=shrink
```

### Enable Hidpi

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"
```

### Fix audio

- Audio codec `ALC887` support: 0x100202, 0x100302, layout 1, 2, 3, 5, 7, 11, 12, 13, 17, 18, 20, 33, 40, 50, 52, 53, 87, 99
- Audio codec `ALC897` support: 0x100402, 0x100500, layout 11, 12, 13, 21, 23, 66, 69, 77, 98, 99
- To test out our layout IDs, we're going to be using the boot-arg `alcid=xxx` (recommend `alcid=11`) where xxx is your layout. Remember that to try layout IDs one at a time. Do not add multiple IDs or alcid boot-args, if one doesn't work then try the next ID and etc

```
config.plist
├── NVRAM
  ├── Add
    ├── 7C436110-AB2A-4BBB-A880-FE41995C9F82
          ├── boot-args | String | alcid=11
```


### Chanage boot default opencore

- Hold Ctrl and enter boot item.

### Download [m3u8](https://greasyfork.org/en/scripts/449581-m3u8%E8%A7%86%E9%A2%91%E4%BE%A6%E6%B5%8B%E4%B8%8B%E8%BD%BD%E5%99%A8-%E8%87%AA%E5%8A%A8%E5%97%85%E6%8E%A2)

### Fix lag mouse

- Remove all `Library/Caches`

#### Unzip multi files

- Cho vào cùng 1 folder
- cmd:

```
cd vào folder chứa file

unzip '*.zip' -d ./
```

###

```
allow pasting
```

```
var styles = `
  .mc_live .mc_l-right{
    display: none
  }
  .mc_live .mc_l-left {
      width: calc(100% - 0px);
      float: left;
  }
`

var styleSheet = document.createElement("style")
styleSheet.textContent = styles
document.head.appendChild(styleSheet)
```


### [Fix gui picker opencore](https://dortania.github.io/OpenCore-Post-Install/cosmetic/gui.html#setting-up-opencore-s-gui)

![image](images/fix-gui-opencore.png)


### Parallels

```
cd desktop/thuoc
xattr -cr * && chmod +x *.sh && sudo ./patch.sh
```
- Or crash
```
codesign -fs – ‘/Applications/Parallels Desktop.app/Contents/Frameworks/91QiuChenly.dylib’
```