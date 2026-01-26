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

# Add ~/.local/bin to PATH
fish_add_path -a ~/.local/bin
# Add go
fish_add_path -a ~/go/bin/

zoxide init --cmd cd fish | source
starship init fish | source

set fish_greeting
set -gx EDITOR nvim
set -gx VISUAL nvim
