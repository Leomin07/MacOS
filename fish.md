### Set fish as default shell termial

```
sudo sh -c 'echo /usr/local/bin/fish >> /etc/shells'
```

```
chsh -s $(which fish)
```

### Fix get Venv python

- Add .fish to end line.

```
source venv/bin/activate.fish
```

### Custom prompt_pwd

- Add to file `/Users/minhtd/.local/share/omf/themes/agnoster/functions`

```

function prompt_pwd --d "Print the current working directory, shortened to fit the prompt"
    set -q argv[1]
    and switch $argv[1]
        case -h --help
            __fish_print_help prompt_pwd
            return 0
    end

    # This allows overriding fish_prompt_pwd_dir_length from the outside (global or universal) without leaking it
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 1

    # Replace $HOME with "~"
    set realhome ~

    # @EDITED by Thiago Andrade
    set tmpdir (basename $PWD)
    set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $tmpdir)
    # ORIGINAL VERSION
    # set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

    if [ $fish_prompt_pwd_dir_length -eq 0 ]
        echo $tmp
    else
        # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
        string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $tmp
    end
end
```
