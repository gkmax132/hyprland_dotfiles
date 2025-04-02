# Hyprland Dotfiles

This repository contains configuration scripts and dotfiles for customizing a Hyprland-based desktop environment.

## Kitty Launcher Script

The `term.sh` script is a universal launcher for the [Kitty terminal emulator](https://sw.kovidgoyal.net/kitty/). It detects your current shell (e.g., Bash, Zsh, Fish) and launches Kitty with a specified theme, then starts an interactive shell session.

### Features
- Automatically detects your current shell using `$SHELL`.
- Applies a custom Kitty theme from `~/.config/kitty/current-theme.conf`.
- Supports Bash, Zsh, Fish, and falls back to Bash for unrecognized shells.
- Runs Kitty with a single instance using a Unix socket (`unix:@mykitty`).

<details>
  <summary>Example</summary>
  
  ![Kitty Theme Selection](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/gifs/kitty_theme_select.gif)
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
  <summary>Example</summary>
  
  ![Waybar Theme Change](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/gifs/waybar_theme_change.gif)
</details>

### Requirements
- `waybar`, `rofi`, `notify-send`, and `systemctl` must be installed and configured.
- Themes must be stored in `~/.config/waybar/themes/` with each theme in its own subdirectory containing `config.jsonc` and `style.css`.

<details>
  <summary>Available Waybar Themes</summary>
  
  - <details>
      <summary>Monochrome</summary>
      
    ![Monochrome Theme](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/monochrome.png)
    </details>
  - <details>
      <summary>Personal</summary>
      
    ![Personal Theme](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/personal.png)
    </details>
  - <details>
      <summary>Cyberpunk</summary>
      
    ![Cyberpunk Theme](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/cyberpunk.png)
    </details>
  - <details>
      <summary>Cyberpunk Red</summary>
      
    ![Cyberpunk Red Theme](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/waybar/cyberpunk_red.png)
    </details>
</details>

## Customization Menu (`menu.sh`)

`menu.sh` is a Bash script that provides an interactive menu via `rofi` to perform various customization actions for your desktop environment. It serves as a central hub to trigger specific scripts for tasks like changing wallpapers, Waybar themes, and more.

### Features
- Displays a menu with the following options:
  - **Change wallpaper**: Runs `change_wallpaper.sh` to update the desktop wallpaper.
  - **Change waybar theme**: Runs `waybar.sh` to switch the Waybar theme.
  - **Kitty theme selector**: Runs `kitty.sh` to select a theme for the Kitty terminal.
  - **Hypr animation selector**: Runs `animation.sh` to adjust Hyprland animations.
  - **Change border**: Runs `change_border.sh` to modify window border styles.
  - **Toggle blur**: Runs `toggle_blur.sh` to enable or disable blur effects.
- Exits with an error code (1) if no valid option is selected.

### Usage
- Run `./menu.sh` to launch the `rofi` menu.
- Select an action using the mouse or keyboard to execute the corresponding script.

<details>
  <summary>Example</summary>
  
  ![Menu.sh Demo](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/gifs/menu_demo.gif)
</details>

### Requirements
- `bash` and `rofi` must be installed.
- All referenced scripts (`change_wallpaper.sh`, `waybar.sh`, `kitty.sh`, `animation.sh`, `change_border.sh`, `toggle_blur.sh`) must exist in `~/.scripts/`.

## Wallpaper Management Scripts

This section describes two Bash scripts for managing desktop wallpapers in a Hyprland environment using `swaybg`: `wallpaper.sh` and `change_wallpaper.sh`. Both scripts set wallpapers, but they differ in their approach and user interaction.

### `wallpaper.sh`
`wallpaper.sh` is a flexible script for setting or restoring wallpapers with customizable display options. It caches the last wallpaper settings for easy restoration.

#### Features
- **Set Wallpaper**: Applies a wallpaper from a specified image path with an optional display mode (e.g., `-m fill`, `-m fit`, defaults to `fill`).
- **Restore Wallpaper**: Uses the `-r` flag to reload the last wallpaper settings from `~/.cache/swaybg/swaybg_last`.
- **Cache Management**: Stores the active wallpaper command in `~/.cache/swaybg/swaybg_last`.
- **Process Control**: Terminates any running `swaybg` instance before applying a new wallpaper.

#### Usage
- `./wallpaper.sh image_path [option]` - Set a new wallpaper (e.g., `./wallpaper.sh ~/image.jpg -m fit`).
- `./wallpaper.sh -r` - Restore the last wallpaper.

### `change_wallpaper.sh`
`change_wallpaper.sh` provides an interactive menu via `rofi` to select and apply wallpapers from a predefined directory, with visual previews and notifications.

#### Features
- **Interactive Selection**: Lists images from `~/.wallpaper/` in a `rofi` menu with icon previews.
- **Wallpaper Application**: Applies the selected wallpaper using `swaybg` with a fixed `-m fill` mode.
- **Cache Management**: Saves the applied wallpaper command to `~/.cache/swaybg/swaybg_last`.
- **User Feedback**: Sends a notification via `notify-send` with the name of the selected wallpaper.
- **Error Handling**: Notifies the user if the wallpaper directory is missing.

#### Usage
- `./change_wallpaper.sh` - Opens the `rofi` menu to choose a wallpaper from `~/.wallpaper/`.

### Shared Requirements
- `swaybg` for wallpaper rendering.
- `rofi` (for `change_wallpaper.sh` only) for the menu interface.
- `notify-send` (for `change_wallpaper.sh` only) for notifications.
- Wallpapers must be accessible in the specified paths (`~/.wallpaper/` for `change_wallpaper.sh` or any path for `wallpaper.sh`).

### Key Differences
- **`wallpaper.sh`** is command-line driven, offering flexibility in options and manual control, while **`change_wallpaper.sh`** is user-friendly with a graphical menu.
- **`wallpaper.sh`** supports custom display modes, whereas **`change_wallpaper.sh`** uses a fixed `fill` mode.
- **`change_wallpaper.sh`** includes icon previews and notifications, which `wallpaper.sh` lacks.

### Example
<details>
  <summary>Demo of change_wallpaper.sh</summary>
  
  ![Wallpaper Change Demo](https://raw.githubusercontent.com/gkmax132/hyprland_dotfiles/refs/heads/main/images/gifs/wallpaper_change.gif)
</details>

