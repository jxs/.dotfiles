# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jxs/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/jxs/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jxs/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/jxs/.fzf/shell/key-bindings.zsh"
