# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="jxs"
export SHELL="/usr/bin/zsh"
export TERM=xterm-256color
export COLORTERM=truecolor
fpath+=~/.zfunc

plugins=(git zsh-autosuggestions pass)

source $ZSH/oh-my-zsh.sh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=147'

# Customize to your needs...
alias cat='bat'
alias vim='nvim'

#go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

#editor
export EDITOR='nvim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
zstyle ':completion:*' special-dirs true

#rust
export CARGO_HOME=~/.cargo
export PATH="$HOME/.cargo/bin:$PATH"

#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ssh-agent
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

