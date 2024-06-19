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
  config = mkIf cfg.enable {
    hm = {
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
          cd = "z";
          cdi = "zi";
        };
      };
      # eza (modern ls replacement)
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
      };
      # zoxide (jump to directories)
      programs.zoxide.enable = true;
      # home.sessionVariables._ZO_ECHO = "1";

      programs.atuin.enable = true;
      programs.skim.enable = true;
      programs.bat.enable = true;
    };

    programs.zsh.enable = true;
  };
}
