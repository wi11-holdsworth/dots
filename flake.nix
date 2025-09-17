{
  description = "NixOS configuration";

  inputs = {
    # keep-sorted start block=yes
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    copyparty.url = "github:9001/copyparty";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    # keep-sorted end
  };

  outputs =
    { nixpkgs, ... }@inputs:
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
