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
      # NOTE: When first launching vscode after installing the extensions
      # they need to be reloaded
      extensions = with pkgs.unstable.vscode-extensions; [
        golang.go
        eamodio.gitlens
        ms-python.python
        vscodevim.vim
        jnoortheen.nix-ide
        ziglang.vscode-zig
      ];
    };
  };
}
