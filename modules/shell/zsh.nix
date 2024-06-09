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

  programs.atuin.enable = true;
}
