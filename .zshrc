# -- variables
export SHELL="/usr/bin/zsh"
export TERM=xterm-256color
export COLORTERM=truecolor
export ZSH_THEME="arrow"
export EDITOR='nvim'
export LANG=en_US.UTF-8
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# -- aliases
alias cat='bat'
alias vim='nvim'
alias gb='git rev-parse --abbrev-ref HEAD'

# -- load zgen
source "/usr/share/zsh/share/zgen.zsh"

# -- zgen packages
if ! zgen saved; then
    zgen oh-my-zsh
    zgen load zsh-users/zsh-autosuggestions
    zgen load 'wfxr/forgit'

    # generate the init script from plugins above
    zgen save
fi

# -- fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
