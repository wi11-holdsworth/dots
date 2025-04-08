{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "feature";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {

  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
