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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ 
    nixpkgs, 
    home-manager, 
    nixvim,	    
    sops-nix,
    ... 

  }: {
    nixosConfigurations."opal" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/opal/configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.srv = import ./hosts/opal/home.nix;
          };
        }

        nixvim.nixosModules.nixvim

        sops-nix.nixosModules.sops {

          defaultSopsFile = /home/srv/.dots/secrets.yaml;
          defaultSopsFormat = "yaml";
          
          age.keyFile = "/home/srv/.config/sops/age/keys.txt";

          secrets = {
            "borgbackup/opal" = {
              onsite = {};
              offsite = {};
            };
            api = {
              njalla = {};
            };
          };
        }
      ];
    };
  };
}
