{
  config,
  inputs,
  lib,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "vscode-server";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled { services.${feature}.enable = true; };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  imports = [ inputs.${feature}.nixosModules.default ];
}
