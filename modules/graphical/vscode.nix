# vscode configuration
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.graphical.alacritty;
in {
  options.modules.graphical.vscode.enable = mkEnableOption "vscode";
  config.hm = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      extensions = with pkgs.unstable.vscode-extensions; [
        golang.go
        eamodio.gitlens
      ];
    };
  };
}
