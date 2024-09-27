{
  description = "My Pop_OS Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {...}: let
    inherit (lib.my) mkOverlays mkPkgs;

    extraSpecialArgs = {
      scriptsDir = ../scripts;
    };

    lib = inputs.nixpkgs.lib.extend (self: _super:
      import ./lib {
        inherit inputs pkgs;
        lib = self;
      });
    overlays =
      (mkOverlays ./overlays)
      // {
        extraPkgs = _self: _super: {system = "x86_64-linux";};
      };
    pkgs = mkPkgs overlays;
  in {
    homeConfigurations = {
      jrl = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
