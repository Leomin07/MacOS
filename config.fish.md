### Custom theme

```
nano ~/.config/fish/config.fish
```

```
if status is-interactive
	set -g theme_nerd_fonts yes
	set -g theme_color_scheme dark
	set -g theme_display_git_default_branch yes
	set -g theme_title_display_process yes
	set -g theme_title_display_path no
	set -g theme_title_use_abbreviated_path no
	set -g theme_date_format "+%d/%m/%y %H:%M"
	set -g theme_display_jobs_verbose yes
	set -g theme_display_user yes
	set -g theme_display_hostname yes
end
```
