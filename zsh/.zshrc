export ZSH="$HOME/.oh-my-zsh"

plugins=(git archlinux zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting colored-man-pages)

export EDITOR='nvim'
export VISUAL='nvim'
export PATH=$PATH:~/.local/bin

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=value'

source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias cr="cargo run"
alias cn="cargo new"
alias cb="cargo build"
alias ct="cargo test"
alias ccl="cargo clippy"
alias :q="exit"
alias mc="make clean"

alias gitlog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias ts="tmux-sessionizer"
alias nvim-update="neovim-update-nightly"

alias ls="eza -l -L=1 --git --icons --color=always --group-directories-first"
alias la="eza -la --git --icons --color=always --group-directories-first"
alias ll="eza -la -T -L=1 --git --icons -color=always --group-directories-first"
alias lt="eza -aT -L=1 --git --icons --color=always --group-directories-first"

# Bat is just superior...
# alias cat="bat"

alias c="clear"

# Use ripgrep instead of grep
alias grep="rg"

alias python="python3"

bindkey -s ^f "tmux-sessionizer\n"

# eval "$(zoxide init --cmd cd zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/zig/
