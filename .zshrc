# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="jxs"
export SHELL="/usr/local/bin/zsh"
fpath+=~/.zfunc
#
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
 plugins=(git git-extras github python django virtualenv osx)

source $ZSH/oh-my-zsh.sh


# Customize to your needs...
alias ls='ls -G'
alias ll='ls -hl'
alias e='emacs -nw'
#homebrew
export PATH=/usr/local/bin:/usr/local/sbin:${PATH}

#go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

#virtualenvwrapper
export VIRTUAL_ENV_DISABLE_PROMPT='1'
export PYTHONDONTWRITEBYTECODE=1

#editor
export EDITOR='emacs -nw'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
zstyle ':completion:*' special-dirs true
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

#rust
export RUST_SRC_PATH=~/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

#rbenv
RBENV_ROOT=/usr/local/var/rbenv

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
