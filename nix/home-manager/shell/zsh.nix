{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=value";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "docker-compose" "zoxide"];
    };

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      c = "clear";
      v = "nvim";
      ts = "tmux-sessionizer";
      cr = "cargo run";
      cn = "cargo new";
      ct = "cargo test";
      ccl = "cargo clippy";
      ":q" = "exit";
      mc = "make clean";

      # Changing "ls" to "eza"
      ls = "eza -l -L=1 --git --icons --color=always --group-directories-first"; # my preferred listing
      la = "eza -la --git --icons --color=always --group-directories-first"; # all files and dirs
      ll = "eza -la -T -L=1 --git --icons -color=always --group-directories-first"; # long format
      lt = "eza -aT -L=1 --git --icons --color=always --group-directories-first"; # tree listing

      # Bat is just superior...
      cat = "bat";

      # Use ripgrep instead of grep
      grep = "rg";

      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#alethkar";

      gitlog = "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
  # eza (modern ls replacement)
  programs.eza.enable = true;
  # zoxide (jump to directories)
  programs.zoxide = {
    enable = true;
    # Automatic cd replacement alias
    options = [
      "--cmd cd"
    ];
  };

  programs.atuin.enable = true;

  programs.skim.enable = true;

  programs.yazi.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
    };
  };

  programs.fd.enable = true;

  home.packages = with pkgs; [
    tree
  ];
}
