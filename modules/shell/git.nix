# Git configuration
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
      userEmail = "jose.r.lopes@tecnico.ulisboa.pt";
      # userEmail = "josersl2003@gmail.com";
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
          dark = true;
        };
      };
    };

    programs.gh.enable = true;
  };
}
