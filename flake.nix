{
  inputs = {
    # The master branch of the NixOS/nixpkgs repository on GitHub.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
   flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.vice = pkgs.callPackage ./pkgs/vice.nix {};
    });
}
