# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="jxs"
export SHELL="/usr/bin/zsh"
export TERM=xterm-256color
export COLORTERM=truecolor
fpath+=~/.zfunc

plugins=(git osx zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=147'

# Customize to your needs...
alias ls='ls -G'
alias ll='ls -hl'
alias cat='bat'
alias e='emacs -nw'
alias v='nvim'
alias vim='nvim'
#PATH
export PATH=/usr/local/bin:/usr/local/sbin:${PATH}

#go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

#editor
export EDITOR='nvim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
zstyle ':completion:*' special-dirs true

#rust
export RUST_SRC_PATH=~/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
export CARGO_HOME=~/.cargo

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
