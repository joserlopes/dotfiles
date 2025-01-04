export ZSH="$HOME/.oh-my-zsh"

plugins=(git archlinux zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting colored-man-pages)

export EDITOR='nvim'
export VISUAL='nvim'
export PATH=$PATH:~/.local/bin

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=value'

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

# Changing "ls" to "eza"
alias ls="eza -l -L=1 --git --icons --color=always --group-directories-first" # my preferred listing
alias la="eza -la --git --icons --color=always --group-directories-first"  # all files and dirs
alias ll="eza -la -T -L=1 --git --icons -color=always --group-directories-first"  # long format
alias lt="eza -aT -L=1 --git --icons --color=always --group-directories-first" # tree listing

# Bat is just superior...
# alias cat="bat"

alias c="clear"

# Use ripgrep instead of grep
alias grep="rg"

source $ZSH/oh-my-zsh.sh

# eval "$(zoxide init --cmd cd zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
