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
alias git-archive='
    # Check that a branch name was provided
    if [ -z "$1" ]; then
        echo "Please provide the name of the branch to archive"
        return 1
    fi

    # Get the current branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # Create a tag for the branch
    tag="archive/$1-$(date +%Y%m%d%H%M%S)"
    git tag "$tag" "$1"

    # Delete the branch from local and origin
    git branch -D "$1"
    git push origin ":$1"

    # Checkout the current branch
    git checkout "$current_branch"
'

alias git-unarchive='
    # Check that a branch name was provided
    if [ -z "$1" ]; then
        echo "Please provide the name of the branch to unarchive"
        return 1
    fi

    # Check that the branch exists as a tag
    tag="archive/$1-*"
    if ! git rev-parse "$tag" >/dev/null 2>&1; then
        echo "No archive tag found for branch '$1'"
        return 1
    fi

    # Restore the branch from the tag and push to origin
    git checkout -b "$1" "$tag"
    git push -u origin "$1"

    # Delete the archive tag
    git tag -d "$tag"
    git push origin ":$tag"
'
