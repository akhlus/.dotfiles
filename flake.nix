{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url="github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager,... }:
    let
      system = "x86_64-linux";
      pkgs=nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations."s340" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
      homeConfigurations={
        sam=home-manager.lib.homeManagerConfiguration{
          inherit pkgs;
          modules=[./home.nix];
        };
      };
    };
}
