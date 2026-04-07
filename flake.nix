{
  description = "A utility for generating Mermaid diagrams from Terraform configurations";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    go-overlay.url = "github:purpleclay/go-overlay";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    go-overlay,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [go-overlay.overlays.default];
      };
    in {
      packages.default = import ./default.nix {
        inherit pkgs;
      };
    })
    // {
      overlays.default = final: prev: {
        terramaid = import ./default.nix {pkgs = final;};
      };
    };
}
