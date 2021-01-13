# .bashrc
stty -ixon

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='ls -l'
alias la='ls -la'
alias xe='emacsclient -t'

PROMPT_COMMAND=
PS1="[\u@\H:\w]\n\$ "

export EDITOR='emacsclient -t'
export VISUAL='emacsclient -c -a emacs'

shopt -s checkwinsize

function e {
    emacsclient -n "$@" &!
}

function iconv_cyrillic {
    iconv -t latin1 "$1" | iconv -f cp1251 -t utf-8
}
