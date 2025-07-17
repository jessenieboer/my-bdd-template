{
  description = "A basic bdd dev flake";
  
  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    }
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
  { 
    flake-utils,
    nixpkgs,
    ...
  }:
  flake-utils.lib.eachDefaultSystem (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        # dev environment
        devShells.default = pkgs.mkShell {
          
          # dependencies needed for developing this package
          buildInputs = with pkgs; [
            cucumber
          ];
        };
      }
    );
}
