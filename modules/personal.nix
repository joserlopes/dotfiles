# non-graphical configuration for personal computers.
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.personal;
in {
  options.modules.personal.enable = mkEnableOption "personal";

  # Home manager module
  config.hm = mkIf cfg.enable {
    home.packages = with pkgs; [
      # dog DNS CLI client (dig alternative)
      dogdns
      # qalc (CLI calculator)
      libqalculate
      # LaTeX
      texlive.combined.scheme-full
      texlab
      # timewarrior (time tracker)
      timewarrior
      # Rust
      rustup
      # typst (markup-based typesetting system)
      unstable.typst
      unstable.typstyle
      # Java VM
      jdk
      # Gleam
      unstable.gleam
      erlang
      rebar3
    ];

    # Golang
    programs.go.enable = true;

    programs.zsh.shellAliases."dig" = "dog";

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
