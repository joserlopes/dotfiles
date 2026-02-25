if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

function fish_user_key_bindings
    bind \cf tmux-sessionizer
    bind \cq beginning-of-buffer
    bind \co backward-word
    bind \cp forward-word
    if functions -q fzf_key_bindings
		fzf_key_bindings
	end
end

# fish_add_path -a ~/.local/bin
# fish_add_path -a ~/go/bin/
# fish_add_path -a ~/.juliaup/bin

# Add ~/.local/bin to PATH
set -gx PATH $HOME/.local/bin $PATH
# Add go
set -gx PATH $HOME/go/bin $PATH
# Add juliaup 
set -gx PATH $HOME/.juliaup/bin $PATH

zoxide init --cmd cd fish | source
starship init fish | source

set fish_greeting
set -gx EDITOR nvim
set -gx VISUAL nvim

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/jrl/.ghcup/bin $PATH # ghcup-env

eval (opam env --switch=default)
