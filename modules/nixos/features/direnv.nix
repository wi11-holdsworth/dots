{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "direnv";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled { programs.${feature}.enable = true; };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
