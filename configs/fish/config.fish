if status is-interactive
    set fish_greeting ""

    alias DD="DRI_PRIME=1"
    alias gs="git status"
    alias ll="ls -lah"
    alias nvim="sudo -E nvim"
    alias c="clear; printf '\033[3J'"

    set -U fish_color_command blue      
    set -U fish_color_param green       
    set -U fish_color_error red         
    set -U fish_color_quote yellow      
    set -U fish_color_option green      
    set -U fish_color_cwd cyan          
    set -U fish_color_autosuggestion grey
    set -U fish_color_end magenta       
    set -gx PATH $PATH /opt/android-sdk/platform-tools
    bind \e\[A history-prefix-search-backward
    bind \e\[B history-prefix-search-forward

    function fish_history_search
        history | fzf --height 40% --reverse --border --info=inline | read -l command
        if test -n "$command"
            commandline --replace -- $command
        end
    end
    bind \cr fish_history_search

    # Переменные среды
    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x PATH $HOME/.local/bin $PATH
end
