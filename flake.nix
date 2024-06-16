# flake.nix
#
# Author: Diogo Correia <me@diogotc.com>
# URL:    https://github.com/diogotcorreia/dotfiles
#
# My config, based on RageKnify's
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
  };

  outputs = inputs @ {self, ...}: let
    inherit (builtins) listToAttrs concatLists attrValues attrNames readDir;
    inherit (inputs.nixpkgs) lib;
    inherit (lib) mapAttrs mapAttrsToList hasSuffix;
    # TODO change
    colors = {
      dark = {
        "base00" = "#002b36"; # background
        "base01" = "#073642"; # lighter background
        "base02" = "#586e75"; # selection background
        "base03" = "#657b83"; # comments, invisibles, line highlighting
        "base04" = "#839496"; # dark foreground
        "base05" = "#93a1a1"; # default foreground
        "base06" = "#eee8d5"; # light foreground
        "base07" = "#fdf6e3"; # light background
        "base08" = "#dc322f"; # red       variables
        "base09" = "#cb4b16"; # orange    integers, booleans, constants
        "base0A" = "#b58900"; # yellow    classes
        "base0B" = "#859900"; # green     strings
        "base0C" = "#2aa198"; # aqua      support, regular expressions
        "base0D" = "#268bd2"; # blue      functions, methods
        "base0E" = "#6c71c4"; # purple    keywords, storage, selector
        "base0F" = "#d33682"; # deprecated, opening/closing embedded language tags
      };
      light = {
        "base00" = "#fdf6e3";
        "base01" = "#eee8d5";
        "base02" = "#93a1a1";
        "base03" = "#839496";
        "base04" = "#657b83";
        "base05" = "#586e75";
        "base06" = "#073642";
        "base07" = "#002b36";
        "base08" = "#dc322f";
        "base09" = "#cb4b16";
        "base0A" = "#b58900";
        "base0B" = "#859900";
        "base0C" = "#2aa198";
        "base0D" = "#268bd2";
        "base0E" = "#6c71c4";
        "base0F" = "#d33682";
      };
    };
    hostNameToColor = hostName: let
      mapping = {
        alethkar = "base09";
      };
      base = mapping."${hostName}";
    in
      colors.light."${base}";

    system = "x86_64-linux";
    user = "nixos";
    userFullName = "NixOS";

    pkg-sets = final: prev: let
      args = {
        system = final.system;
        config.allowUnfree = true;
      };
    in {
      unstable = import inputs.nixpkgs-unstable args;
    };

    overlaysDir = ./overlays;

    overlays =
      [pkg-sets]
      ++ mapAttrsToList
      (name: _: import "${overlaysDir}/${name}" {inherit inputs;})
      (readDir overlaysDir);

    pkgs = import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    spicetifyPkgs = inputs.spicetify-nix.packages.${system}.default;

    allModules = mkModules ./modules;

    # Imports every nix module from a directory, recursively.
    mkModules = dir:
      concatLists (attrValues (mapAttrs (name: value:
        if value == "directory"
        then mkModules "${dir}/${name}"
        else if value == "regular" && hasSuffix ".nix" name
        then [(import "${dir}/${name}")]
        else []) (readDir dir)));

    # Imports every host defined in a directory.
    mkHosts = dir:
      listToAttrs (map (name: {
        inherit name;
        value = inputs.nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit
              inputs
              user
              userFullName
              colors
              spicetifyPkgs
              ;
            configDir = ./config;
            hostColor = hostNameToColor name;
            hostName = name;
          };
          modules =
            [
              {networking.hostName = name;}
              (dir + "/${name}/hardware.nix")
              (dir + "/${name}/configuration.nix")
              inputs.home.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [inputs.spicetify-nix.homeManagerModule];
                };
              }
              inputs.impermanence.nixosModules.impermanence
            ]
            ++ allModules;
        };
      }) (attrNames (readDir dir)));
  in {nixosConfigurations = mkHosts ./hosts;};
}
