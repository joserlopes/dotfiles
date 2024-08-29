# Firefox web browser configuration
{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.default = {
      id = 0;
      isDefault = true;

      search = {
        force = true;
        default = "Brave Search";
        engines = {
          "Brave Search" = {
            urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
          };

          "Nix Options" = {
            definedAliases = ["!nixopt"];
            urls = [{template = "https://search.nixos.org/options?query={searchTerms}";}];
          };

          "Nix Wiki" = {
            definedAliases = ["!nix"];
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
          };

          "Home Manager - Options Search" = {
            definedAliases = ["!hm"];
            urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
          };

          "My NixOS - Options Search" = {
            definedAliases = ["!mynix"];
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
          };
        };
      };

      settings = {
        # Disable privacy invasive "private attribution" ad-tracking "feature"
        "dom.private-attribution.submission.enabled" = false;

        # Change page scaling
        "layout.css.devPixelsPerPx" = 1.2;

        # Never remember passwords
        "signon.rememberSignons" = false;

        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;

        # Restore previous session
        "browser.startup.page" = 3;

        # Enable userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
