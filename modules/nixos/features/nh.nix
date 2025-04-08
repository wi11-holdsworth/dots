{ config, lib, userName, ... }:
let
  # declare the module name and its local module dependencies
  feature = "nh";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    programs.${feature} = {
      enable = true;
      clean.enable = true;
      flake = "/home/${userName}/.dots";
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
