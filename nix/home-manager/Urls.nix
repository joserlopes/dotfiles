{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) escapeShellArg getAttr attrNames;

  Urls = {
    ES = "https://fenix.tecnico.ulisboa.pt/disciplinas/QS11/2024-2025/1-semestre";
    ES-Project = "https://github.com/joserlopes/Software-Specification";
    CCEIC = "https://fenix.tecnico.ulisboa.pt/disciplinas/CCEIC11/2024-2025/1-semestre";
    ALC = "https://fenix.tecnico.ulisboa.pt/disciplinas/ALC11/2024-2025/1-semestre";
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
