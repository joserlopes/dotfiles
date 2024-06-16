# modules/zsh.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# zsh (with oh-my-zsh) configuration.
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh.enable = mkEnableOption "zsh";

  # Home manager module
  config.hm = mkIf cfg.enable {
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
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };

    # zoxide (jump to directories)
    programs.zoxide.enable = true;
  };
}
