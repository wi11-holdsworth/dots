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

  outputs =
    { nixpkgs, agenix, ... }@inputs:
    let
      commonSystem =
        {
          hostName ? "nixos",
          userName ? "will",
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/${hostName}/configuration.nix ];
          specialArgs = {
            inherit inputs;
            inherit hostName;
            inherit userName;
            inherit system;
          };
          inherit system;
        };
    in
    {
      nixosConfigurations = {
        desktop = commonSystem { hostName = "desktop"; };
        laptop = commonSystem { hostName = "laptop"; };
        server = commonSystem {
          hostName = "server";
          userName = "srv";
        };
      };
    };
}
