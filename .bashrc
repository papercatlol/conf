# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
stty -ixon

alias ..='cd ..'
alias vim='vimx'
alias la='ls -la'

PROMPT_COMMAND=
PS1="[\u@\H:\w]\n\$ "
EDITOR='vim'
