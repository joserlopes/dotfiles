{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "tmux-sessionizer" (builtins.readFile ./tmux-sessionizer))
  ];
}
