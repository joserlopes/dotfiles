{ config, pkgs, ... }:

{
  imports = [
    ./dev/languages.nix
  ];

  home.username = "jrl";
  home.homeDirectory = "/home/jrl";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    neofetch
    feh
  ];
  programs.home-manager.enable = true;
}

