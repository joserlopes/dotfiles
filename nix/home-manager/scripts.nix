# Useful scripts
{
  pkgs,
  scriptsDir,
  ...
}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "tmux-sessionizer" (builtins.readFile "${scriptsDir}/tmux-sessionizer"))
    (writeShellScriptBin "nvim-update" (builtins.readFile "${scriptsDir}/neovim-update-nightly"))
  ];
}
