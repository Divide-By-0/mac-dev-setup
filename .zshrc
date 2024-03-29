source ~/.bashrc
export PATH="$PATH:/Users/aayushgupta/.foundry/bin"

##### STARTUP
echo "Reading zshrc..."
RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
RPS2=$RPS1

##### BINDINGS
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

##### VIM STUFF
bindkey '\e' vi-cmd-mode

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

##### HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILESIZE=100000000 # More history in bashrc
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
HISTFILE=~/.zsh_history
test "$(ps -ocommand= -p $PPID | awk '{print $1}')" = 'script' || (script -F $HOME/bash_histories_with_outputs/$(date +"%d-%b-%y_%H-%M-%S")_shell.log)

#### COLORS
alias ll='ls -al'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

autoload -U colors && colors
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%1~%{$reset_color%} %% "

### Git Archive and Unarchive
# Function to archive a branch
function git-archive() {
    if [ -z "$1" ]; then
        echo "Please provide the name of the branch to archive"
        return 1
    fi
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    tag="archive/$1-$(date +%Y%m%d%H%M%S)"
    git tag "$tag" "$1"
    git branch -D "$1"
    git push origin ":$1"
    git checkout "$current_branch"
}

# Function to unarchive a branch
function git-unarchive() {
    if [ -z "$1" ]; then
        echo "Please provide the name of the archive tag to restore"
        return 1
    fi
    git checkout -b "$1" "refs/tags/$1"
    git push --set-upstream origin "$1"
}
