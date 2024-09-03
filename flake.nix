{
  inputs = {
    # The master branch of the NixOS/nixpkgs repository on GitHub.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    bsp-info = {
      url = "github:replaycoding/bspinfo";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vice-standalone = {
      url = "github:replaycoding/vice_standalone";
      flake = false;
    };

    dataminer = {
      url = "github:replaycoding/tf2-dataminer";
      flake = false;
    };

    pics-watcher = {
      url = "github:replaycoding/PICSWatcher";
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
      rec {
        packages.bsp-info = inputs.bsp-info.defaultPackage.${system};
        packages.vice = pkgs.callPackage ./pkgs/vice.nix { src = inputs.vice-standalone; };
        packages.dataminer = pkgs.callPackage ./pkgs/dataminer.nix {
          src = inputs.dataminer;
          inherit (packages) vice bsp-info;
        };

        packages.pics-watcher = pkgs.callPackage ./pkgs/pics-watcher.nix {
          src = inputs.pics-watcher;
          inherit (packages) dataminer;
        };
    });
}
