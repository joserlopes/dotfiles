# GTK config
{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      # package = pkgs.nordic;
      # name = "Nordic-darker";
      name = "Pop-dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
      # name = "Pop";
    };
  };
}
