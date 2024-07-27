# programming languages
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.languages;
in {
  options.modules.languages.enable = mkEnableOption "languages";

  # Home manager module
  config.hm = mkIf cfg.enable {
    home.packages = with pkgs; [
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
      # Python
      (pkgs.python3.withPackages (
        p:
          with p; [
            tox
            virtualenv
            ipython
            jupyter
          ]
      ))
      # Lua
      lua
      # Zig
      unstable.zig
      # Elixir
      elixir
    ];

    # Golang
    programs.go.enable = true;

    # Bun
    programs.bun = {
      enable = true;
      package = pkgs.unstable.bun;
    };
  };
}
