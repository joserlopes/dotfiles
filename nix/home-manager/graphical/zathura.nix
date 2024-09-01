# PDF viewer
{...}: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      sandbox = "none"; # fix links not opening on browser
    };
  };
}
