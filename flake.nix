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
  };

  outputs = { 
    nixpkgs, 
    home-manager, 
    nixvim,	    
    ... 
  }: let 
    specialArgs = import ./sysConfig.nix;
  in {
    nixosConfigurations.${specialArgs.host} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      inherit specialArgs;
      modules = [
        ./hosts/${specialArgs.host}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = specialArgs;
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${specialArgs.user}" = import ./hosts/${specialArgs.host}/home.nix;
          };
        }
        nixvim.nixosModules.nixvim
      ];
    };
  };
}
