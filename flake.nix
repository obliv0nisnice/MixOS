{
  description = "NixOS Mac profile flake ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixMac.url = "github:nix-community/nixos-apple-silicon";

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager-unstable";
    };

    nvf.url = "github:notashelf/nvf";
    swww.url = "github:LGFae/swww";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs @ { nixpkgs, ... }:
  let
    username = "oblivion";
  in {
    nixosConfigurations = {

      macbook = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";

        specialArgs = {
          inherit inputs username;
          host = "macbook";
          profile = "apple-silicon";
        };

        modules = [
          ./hardware-configuration.nix
          inputs.nixMac.nixosModules.apple-silicon-support
          ./modules/core
          ./profiles/macbook
        ];
      };
    };
  };
}

