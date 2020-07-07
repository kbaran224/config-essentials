#{{{ Prompt

# Git prompt in bash

# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=1

# theme file is ~/.git-prompt-colors.sh
GIT_PROMPT_THEME=Custom

# Standard user prompt, VENV unusable until virtualenvwrapper is used
VENV=''
export PS1="\[\e[1;31m\]$VENV\[\e[m\]\[\e[1;32m\] \w \[\e[m\]\[\e[1;36m\]>\[\e[m\] "


#}}}

#{{{ Source files

source ~/.bash-git-prompt/gitprompt.sh
source ~/.bash-git-prompt/prompt-colors.sh
source /usr/share/bash-completion/completions/git

#}}}

#{{{ Exports - tools and PATH variable

# Standard executables locations
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Git prompt
export PATH=$HOME/.bash-git-prompt:$PATH

# Go lang executables
export GOPATH=$HOME/src/go

export PATH=$GOPATH:$PATH
export PATH=$GOPATH/bin:$PATH

# Rust - cargo installed binaries
export PATH=$HOME/.cargo/bin:$PATH

# Common tools
export PAGER="less"
export MANPAGER="less"
export EDITOR="nvim"

# LS_COLORS variable
#export LS_COLORS="$(vivid generate molokai)"

#}}}

#{{{ Binds
# Ctrl + O to invoke lfcd
bind '"\C-o":"lfcd\C-m"'

#}}}

#{{{ Functions 
# lfcd - stay in the current lf's dir
lfcd () {
    tmp="$(mktemp)"
    fid="$(mktemp)"
    lf -command '$printf $id > '"$fid"'' -last-dir-path="$tmp" "$@"
    id="$(cat "$fid")"
    archivemount_dir="/tmp/__lf_archivemount_$id"
    if [ -f "$archivemount_dir" ]; then
        cat "$archivemount_dir" | \
            while read -r line; do
                sudo umount "$line"
                rmdir "$line"
            done
        rm -f "$archivemount_dir"
    fi
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

#}}}

#{{{ Aliases

# Colorize the ls output
alias ls='ls --color=auto'

# Use a long listing format
alias l='ls -al --color=auto'

# Show hidden files
alias l.='ls -d .* --color=auto'

# Use neovim instead of vim
alias vim='nvim'

# Use given tmux configuration file
alias tmux='tmux -f $HOME/.config/tmux/tmux.conf'

# Use nvim as pager
alias vless='nvim -u /usr/share/nvim/runtime/macros/less.vim'

# Gitflow aliases
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gm='git merge'
alias gs='git status'
alias gd='git diff'
alias gl='git log --pretty=oneline'
#}}}

# {{{ SSH Agent

if [ -z "$(pgrep ssh-agent)" ]; then
   rm -rf /tmp/ssh-*
   eval $(ssh-agent -s) > /dev/null
else
   export SSH_AGENT_PID=$(pgrep ssh-agent)
   export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name agent.*)
fi

#}}}
