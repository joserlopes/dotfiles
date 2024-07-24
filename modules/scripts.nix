# useful scripts
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.scripts;
in {
  options.modules.scripts.enable = mkEnableOption "scripts";

  # Home manager module
  config.hm = mkIf cfg.enable {
    home.packages = with pkgs; [
      (writeShellScriptBin "tmux-sessionizer" (builtins.readFile ../config/scripts/tmux-sessionizer))
      (writeShellScriptBin "URL" (builtins.readFile ../config/scripts/URL))
    ];
  };
}
