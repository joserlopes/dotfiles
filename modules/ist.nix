# Configuration for services and programs needed while studying
# at Instituto Superior Técnico (IST)
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf escapeShellArg getAttr attrNames;
  cfg = config.modules.ist;

  courseUrls = {
    CG = "https://fenix.tecnico.ulisboa.pt/disciplinas/CGra23/2023-2024/2-semestre";
    Comp = "https://fenix.tecnico.ulisboa.pt/disciplinas/Com3/2023-2024/2-semestre";
    PIC = "https://fenix.tecnico.ulisboa.pt/disciplinas/PLic23-2/2023-2024/2-semestre";
  };
in {
  options.modules.ist.enable = mkEnableOption "ist";

  config = mkIf cfg.enable {
    # Course shortcuts
    hm.home.packages = map (courseName:
      pkgs.writeScriptBin courseName ''
        ${pkgs.xdg-utils}/bin/xdg-open ${
          escapeShellArg (getAttr courseName courseUrls)
        }
      '') (attrNames courseUrls);
  };
}
