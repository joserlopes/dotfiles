{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=value";
    };

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      c = "clear";
      v = "nvim";
    };
  };

  # eza (modern ls replacement)
  programs.eza.enable = true;
  programs.eza.enableZshIntegration = true;

  programs.atuin.enable = true;

  programs.zoxide.enable = true;
  home.sessionVariables._ZO_ECHO = "1";
}
