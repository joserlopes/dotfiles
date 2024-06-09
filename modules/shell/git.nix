{...}: {
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "José Lopes";
    userEmail = "josersl2003@gmail.com";
  };

  programs.gh.enable = true;
}
