{
  lib,
  inputs,
  ...
}: let
  inherit (lib.my) rakeLeaves;

  /*
  Synopsis: mkPkgs overlays

  Generate an attribute set representing Nix packages with custom overlays.

  Inputs:
  - overlays: An attribute set of overlays to apply on top of the main Nixpkgs.

  Output Format:
  An attribute set representing Nix packages with custom overlays applied.
  The function imports the main Nixpkgs and applies additional overlays defined in the `overlays` argument.
  It then merges the overlays with the provided `argsPkgs` attribute set.
  */
  mkPkgs = overlays: let
    argsPkgs = {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in
    import inputs.nixpkgs ({
        overlays =
          [
            (_self: _super: {
              unstable = import inputs.nixpkgs-unstable argsPkgs;
            })
          ]
          ++ lib.attrValues overlays;
      }
      // argsPkgs);

  /*
  Synopsis: mkOverlays overlaysDir

  Generate overlays for Nix expressions found in the specified directory.

  Inputs:
  - overlaysDir: The path to the directory containing Nix expressions.

  Output Format:
  An attribute set representing Nix overlays.
  The function recursively scans the `overlaysDir` directory for Nix expressions and imports each overlay.
  */
  mkOverlays = overlaysDir:
    lib.mapAttrsRecursive
    (_: module: import module {inherit rakeLeaves inputs;})
    (rakeLeaves overlaysDir);
in {
  inherit mkPkgs mkOverlays;
}
