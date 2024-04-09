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
    zgen load zsh-users/zsh-history-substring-search
    zgen load 'wfxr/forgit'

    # generate the init script from plugins above
    zgen save
fi

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=cyan,fg=black'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white'

# -- variables
export SHELL="/usr/bin/zsh"
export TERM=xterm-256color
export COLORTERM=truecolor
export ZSH_THEME="arrow"
export EDITOR='nvim'
export LANG=en_US.UTF-8
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export LS_COLORS="di=34;5;218;01:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# -- aliases
# alias cat='bat'
alias vim='nvim'
alias gb='git rev-parse --abbrev-ref HEAD'

# -- fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
