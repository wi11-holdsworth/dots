{ config, hostName, inputs, lib, userName, ... }:
let
  # declare the module name and its local module dependencies
  feature = "home-manager";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    home-manager = {
      users.${userName} = import ../../../hosts/${hostName}/home.nix;
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit userName; };
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
