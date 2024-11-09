# GTK config
{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      # package = pkgs.nordic;
      # name = "Nordic-darker";
      # package = pkgs.kanagawa-gtk-theme;
      # name = "Kanagawa-B";
      # package = pkgs.gruvbox-dark-gtk;
      name = "Pop-dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
      # name = "Pop";
    };
  };
}
