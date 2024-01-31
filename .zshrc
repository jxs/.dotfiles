# -- variables
export SHELL="/usr/bin/zsh"
export TERM=xterm-kitty
export COLORTERM=truecolor
export ZSH_THEME="arrow"
export EDITOR='nvim'
export LANG=en_US.UTF-8
export PATH=$PATH:/home/jxs/.cargo/bin

# -- aliases
alias cat='bat'
alias vim='nvim'
alias gb='git rev-parse --abbrev-ref HEAD'
alias ssh="kitty +kitten ssh"

# -- load zgen
source "/usr/share/zsh/share/zgen.zsh"

# -- zgen packages
if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/pass
    zgen load zsh-users/zsh-autosuggestions
    zgen load 'wfxr/forgit'

    # generate the init script from plugins above
    zgen save
fi

# -- fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
