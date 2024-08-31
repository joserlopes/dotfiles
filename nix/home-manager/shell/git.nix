# Git configuration
{...}: let
  messageTemplateDir = "../../../misc";
in {
  programs.git = {
    enable = true;
    userName = "José Lopes";
    userEmail = "jose.r.lopes@tecnico.ulisboa.pt";
    # userEmail = "josersl2003@gmail.com";
    extraConfig = {
      diff.tool = "vimdiff";
      init.defaultBranch = "main";
      commit.template = "${messageTemplateDir}/gitmessage.txt";
      commit.verbose = true;
    };
    delta = {
      options = {
        features = "decorations";
        line-numbers = true;
        dark = true;
      };
    };
  };

  programs.gh.enable = true;
}
