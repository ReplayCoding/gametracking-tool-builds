{
  inputs = {
    # The master branch of the NixOS/nixpkgs repository on GitHub.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    convar-dumper = {
      url = "git+https://github.com/replaycoding/netvar-dumper?ref=convars&submodules=1";
      flake = false;
    };

    vice-standalone = {
      url = "github:replaycoding/vice_standalone";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
   flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      in
      {
        packages.vice = pkgs.callPackage ./pkgs/vice.nix { src = inputs.vice-standalone; };
        packages.convar-dumper = pkgs.pkgsi686Linux.callPackage ./pkgs/convar-dumper.nix { src = inputs.convar-dumper; };
    });
}
