{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  # basic configuration of git, please change to your own
  programs.tmux = {
    enable = true;
  };
}
