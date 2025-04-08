{ config, inputs, lib, system, ... }:
let
  # declare the module name and its local module dependencies
  feature = "age";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    age.identityPaths = [ "/home/*/.ssh/id_ed25519" ];
    environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
  };

  imports = [ inputs.agenix.nixosModules.default ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
