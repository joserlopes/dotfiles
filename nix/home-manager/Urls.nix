{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) escapeShellArg getAttr attrNames;

  Urls = {
    CG = "https://fenix.tecnico.ulisboa.pt/disciplinas/CGra23/2023-2024/2-semestre";
    Comp = "https://fenix.tecnico.ulisboa.pt/disciplinas/Com3/2023-2024/2-semestre";
    PIC = "https://fenix.tecnico.ulisboa.pt/disciplinas/PLic23-2/2023-2024/2-semestre";
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
