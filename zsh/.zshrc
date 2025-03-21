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
alias cat="bat"

alias c="clear"

# Use ripgrep instead of grep
alias grep="rg"

alias python="python3"
alias lisp="sbcl"

bindkey -s ^f "tmux-sessionizer\n"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/zig/

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/jrl/.opam/opam-init/init.zsh' ]] || source '/home/jrl/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# bun completions
[ -s "/home/jrl/.bun/_bun" ] && source "/home/jrl/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f "/home/jrl/.ghcup/env" ] && . "/home/jrl/.ghcup/env" # ghcup-env
