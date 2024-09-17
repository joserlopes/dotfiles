# Firefox web browser configuration
{...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;

      search = {
        force = true;
        default = "Google";
        engines = {
          "Google" = {
            urls = [{template = "https://google.com/search?q={searchTerms}";}];
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

          "Nix Packages - Options Search" = {
            definedAliases = ["!nixpkgs"];
            urls = [{template = "https://search.nixos.org/packages?channel=24.05&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
          };

          "Repology - Options Search" = {
            definedAliases = ["!repo"];
            urls = [{template = "https://repology.org/project/{searchTerms}/versions";}];
          };

          "Rust docs - Options Search" = {
            definedAliases = ["!rs-docs"];
            urls = [{template = "https://docs.rs/{searchTerms}/latest/{searchTerms}/";}];
          };

          "Rust std library - Options Search" = {
            definedAliases = ["!rs-std"];
            urls = [{template = "https://doc.rust-lang.org/std/?search={searchTerms}";}];
          };

          "Priberam Dicionário da Lingua Portuguesa" = {
            definedAliases = ["!prib"];
            urls = [{template = "https://dicionario.priberam.org/{searchTerms}";}];
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
