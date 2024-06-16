# modules/home/shell/git.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# Git configuration. (Based on RageKnify's)
{
  lib,
  config,
  configDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.shell.git;
in {
  options.modules.shell.git.enable = mkEnableOption "git";

  config.hm = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "José Lopes";
      userEmail = "josersl2003@gmail.com";
      extraConfig = {
        diff.tool = "vimdiff";
        init.defaultBranch = "main";
        commit.template = "${configDir}/gitmessage.txt";
        commit.verbose = true;
      };
      delta = {
        enable = config.modules.personal.enable;
        options = {
          features = "decorations";
          line-numbers = true;
        };
      };
    };

    programs.gh.enable = true;
  };
}
