# Hyprland Dotfiles
<details> 
  <summary> Waybar themes </summary>
  
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

### Kitty Launcher Script

The `term.sh` script is a universal launcher for the Kitty terminal emulator. It detects your current shell (e.g., Bash, Zsh, Fish) and launches Kitty with a specified theme, then starts an interactive shell session.

### Features
- Automatically detects your current shell using `$SHELL`.
- Applies a custom Kitty theme from `~/.config/kitty/current-theme.conf`.
- Supports Bash, Zsh, Fish, and falls back to Bash for unrecognized shells.
- Runs Kitty with a single instance using a Unix socket (`unix:@mykitty`).
