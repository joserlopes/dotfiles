{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) escapeShellArg getAttr attrNames;

  Urls = {
    AS = "https://fenix.tecnico.ulisboa.pt/disciplinas/ASof11/2024-2025/1-semestre";
    SSof = "https://fenix.tecnico.ulisboa.pt/disciplinas/SSof11/2024-2025/1-semestre";
    GitHub = "https://github.com/joserlopes";
    dotfiles = "https://github.com/joserlopes/dotfiles";
  };
in {
  home.packages = map (Url:
    pkgs.writeScriptBin Url ''
      ${pkgs.xdg-utils}/bin/xdg-open ${
        escapeShellArg (getAttr Url Urls)
      }
    '') (attrNames Urls);
}
