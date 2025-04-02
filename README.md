# Hyprland Dotfiles

## Kitty Launcher Script

The `term.sh` script is a universal launcher for the Kitty terminal emulator. It detects your current shell (e.g., Bash, Zsh, Fish) and launches Kitty with a specified theme, then starts an interactive shell session.

### Features
- Automatically detects your current shell using `$SHELL`.
- Applies a custom Kitty theme from `~/.config/kitty/current-theme.conf`.
- Supports Bash, Zsh, Fish, and falls back to Bash for unrecognized shells.
- Runs Kitty with a single instance using a Unix socket (`unix:@mykitty`).
<details>
<summary> Example </summary>
  
![image](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/gifs/kitty_theme_select.gif)

</details>

## Waybar Theme Switcher

`waybar.sh` is a Bash script designed to manage and switch [Waybar](https://github.com/Alexays/Waybar) themes seamlessly. It allows users to select a theme from a predefined directory using `rofi` as a menu interface or restore the previously used theme with the `-r` flag. The script handles theme caching, restarts Waybar with the selected configuration, and provides user feedback via notifications.

### Features
- **Theme Selection**: Lists available themes from `~/.config/waybar/themes/` and lets the user pick one via `rofi`.
- **Theme Restoration**: Uses the `-r` flag to reload the last applied theme stored in `~/.cache/waybar_last_theme`.
- **Waybar Management**: Terminates any running Waybar instance, restarts the `xdg-desktop-portal` service, and launches Waybar with the chosen theme's `config.jsonc` and `style.css`.
- **User Feedback**: Displays a notification with the name of the applied theme using `notify-send`.

### Usage
- Run `./waybar.sh` to open the theme selection menu.
- Run `./waybar.sh -r` to restore the last used theme.
  <details>
    <summary> Example </summary>
  
  ![image](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/gifs/waybar_theme_change.gif)

  </details>
### Requirements
- `waybar`, `rofi`, `notify-send`, and `systemctl` must be installed and configured.
- Themes must be stored in `~/.config/waybar/themes/` with each theme in its own subdirectory containing `config.jsonc` and `style.css`.

<details> 
  <summary> available Waybar themes </summary>
  
   - 
     <details> 
       <summary> Monochrome </summary>
    
      ![image](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/monochrome.png)
  -
     <details>
      <summary> Personal </summary>

      ![image](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/personal.png) 
  -
     <details>
      <summary> Cyberpunk </summary>

      ![image](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/cyberpunk.png) 
  -
     <details>
      <summary> Cyberpunk Red </summary>

      ![image](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/cyberpunk_red.png) 
      
     </details>
</details>
