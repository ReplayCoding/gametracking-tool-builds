{
  inputs = {
    # The master branch of the NixOS/nixpkgs repository on GitHub.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    convar-dumper = {
      url = "git+https://github.com/replaycoding/convar-dumper?submodules=1";
      flake = false;
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
        packages.vice = pkgs.callPackage ./pkgs/vice.nix { src = inputs.vice-standalone; };
        packages.convar-dumper = pkgs.pkgsi686Linux.callPackage ./pkgs/convar-dumper.nix { src = inputs.convar-dumper; };
        packages.dataminer = pkgs.callPackage ./pkgs/dataminer.nix {
          src = inputs.dataminer;
          inherit (packages) vice convar-dumper;
        };

        packages.pics-watcher = pkgs.callPackage ./pkgs/pics-watcher.nix {
          src = inputs.pics-watcher;
          inherit (packages) dataminer;
        };
    });
}
