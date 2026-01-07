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
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # keep-sorted end
  };

  outputs =
    {
      # keep-sorted start
      agenix,
      home-manager,
      nixpkgs,
      nur,
      # zen-browser,
      # keep-sorted end
      ...
    }@inputs:
    let
      commonSystem =
        {
          hostName ? "nixos",
          userName ? "will",
          system ? "x86_64-linux",
        }:
        let
          util = import ./util.nix;
        in
        nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/${hostName}/configuration.nix
            nur.modules.nixos.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.${userName}.imports = [
                  ./hosts/${hostName}/home.nix
                  agenix.homeManagerModules.default
                  # zen-browser.homeModules.twilight
                ];
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  inherit userName hostName util;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ];
          specialArgs = {
            inherit
              inputs
              hostName
              userName
              system
              util
              ;
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
