# Useful scripts
{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "tmux-sessionizer" (builtins.readFile ../../scripts/tmux-sessionizer))
    (writeShellScriptBin "nvim-udpate" (builtins.readFile ../../scripts/neovim-update-nightly))
  ];
}
