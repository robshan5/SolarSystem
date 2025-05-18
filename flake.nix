{
  description = "Julia project with CairoMakie support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          shell = pkgs.zsh;
          packages = with pkgs;[
            julia-bin
            tree-sitter-grammars.tree-sitter-julia
          ];

          shellHook = ''
            export JULIA_PROJECT=.
            echo "Julia dev shell is active"
            exec zsh
          '';
        };
      });
}

