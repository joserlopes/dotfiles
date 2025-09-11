if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/jrl/.opam/opam-init/init.fish' && source '/home/jrl/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

# Add ~/.local/bin to PATH
fish_add_path -a ~/.local/bin
# Add ~/zig to PATH
fish_add_path -a ~/zig
# Add intelij
fish_add_path -a ~/Intelij/bin/
# Add flutter
fish_add_path -a ~/flutter/bin/
# Add go
fish_add_path -a ~/go/bin/

bind \cf tmux-sessionizer
set fish_greeting

zoxide init --cmd cd fish | source
starship init fish | source
mise activate fish | source
