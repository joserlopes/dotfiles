# PDF viewer
{...}: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      sandbox = "none"; # fix links not opening on browser
      window-height = 3000;
      window-width = 3000;
    };
  };
}
