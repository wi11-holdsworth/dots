{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { nixpkgs, agenix, ... }@inputs:
    let
      commonSystem = hostName:
        nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/${hostName}/configuration.nix ];
          specialArgs = {
            inherit inputs;
            hostName = "${hostName}";
          };
          system = "x86_64-linux";
        };
    in {
      nixosConfigurations = {
        desktop = commonSystem "desktop";
        server = commonSystem "server";
      };
    };
}
