#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias src='source /home/sultan/.bashrc'
alias die='shutdown now'
alias get='sudo pacman -S'
alias search='pacman -Ss'
alias yget='yay -S'
alias ysearch='yay -Ss'
# excuse the language
alias fuck='sudo pacman -Rns'
alias c='clear'
alias src='source /home/sultan/.bashrc'
alias check='ps aux | grep'

PS1="[\u \W] \$ "

# PS1='[\u@\h \W]\$ '
# export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim
export VISUAL=nvim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
bind -s 'set completion-ignore-case on'
