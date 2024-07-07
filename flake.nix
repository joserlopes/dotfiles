# My config, based on Diogo Correia's
{
  description = "Nix configuration for PCs and servers.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence/master";
    home = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs @ {...}: let
    inherit (lib.my) mkHosts mkOverlays mkPkgs mkProfiles;

    systemFlakePath = "github:joserlopes/dotfiles/NixOS";

    user = "jrl";
    userFullName = "Jose Lopes";

    extraArgs = {
      inherit
        systemFlakePath # TODO move to profile
        user
        userFullName
        ;
      configDir = ./config;
    };

    lib = inputs.nixpkgs.lib.extend (self: _super:
      import ./lib ({
          inherit inputs profiles pkgs nixosConfigurations;
          lib = self;
        }
        // extraArgs));

    extraPackages = {system, ...}: {
      agenix = inputs.agenix.packages.${system}.default;
      lidl-to-grocy = inputs.lidl-to-grocy.packages.${system}.default;
      spicetify = inputs.spicetify-nix.packages.${system}.default;
    };

    overlays =
      (mkOverlays ./overlays)
      // {
        extraPkgs = _self: _super: (extraPackages {system = "x86_64-linux";});
      };
    pkgs = mkPkgs overlays;
    nixosConfigurations = mkHosts ./hosts {
      inherit extraArgs;
      # TODO move to profiles
      extraModules = [
        {
          hardware.enableRedistributableFirmware = true;
        }
        inputs.home.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [inputs.spicetify-nix.homeManagerModule];
          };
        }
      ];
    };
    profiles = mkProfiles ./profiles;
  in {
    inherit nixosConfigurations;

    # Packages are here so they are built by CI and cached
    packages = {
      # x86_64-linux = {
      #   attic = inputs.attic.packages.x86_64-linux.attic-nixpkgs.override {clientOnly = true;};
      #     # This is what hera is using at the moment
      #     postgresql = inputs.nixpkgs.legacyPackages.x86_64-linux.postgresql_14;
      #   };
      #
      #   # TODO this should be auto generated
      #   inherit (pkgs.my) flask-unsign pycdc troupe;
      # };
    };

    formatter = {
      x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
  };
}
