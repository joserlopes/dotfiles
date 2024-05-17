# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'
export VISUAL='nvim'

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
alias ls='eza -l -L=1 --git --icons --color=always --group-directories-first' # my preferred listing
alias la='eza -la --git --icons --color=always --group-directories-first'  # all files and dirs
alias ll='eza -la -T -L=1 --git --icons -color=always --group-directories-first'  # long format
alias lt='eza -aT -L=1 --git --icons --color=always --group-directories-first' # tree listing

# Bat is just superior...
alias cat="bat"

alias c="clear"

# Use ripgrep instead of grep
alias grep="rg"

export PATH=$PATH:~/.local/bin
export TERMINAL=alacritty
# export SKIM_DEFAULT_OPTIONS="$SKIM_DEFAULT_OPTIONS \
# --color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=value'
. "$HOME/.cargo/env"
export PATH=$PATH:/home/joselopes/.spicetify

# opam configuration
[[ ! -r /home/joselopes/.opam/opam-init/init.zsh ]] || source /home/joselopes/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/joselopes/.ghcup/env" ] && source "/home/joselopes/.ghcup/env" # ghcup-env

QT_STYLE_OVERIDE=GTK+

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/joselopes/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"

# bun completions
[ -s "/home/joselopes/.bun/_bun" ] && source "/home/joselopes/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
