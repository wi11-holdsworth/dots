{
  config,
  lib,
  nixosConfig,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "zellij";
  homeManagerDependencies = with config; [ bash ];
  nixosDependencies = with nixosConfig; [ core ];

  # helper functions
  homeManagerDependenciesEnabled = (lib.all (dep: dep.enable) homeManagerDependencies);
  nixosDependenciesEnabled = (lib.all (dep: dep.enable) nixosDependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && nixosDependenciesEnabled && homeManagerDependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      settings.theme = "catppuccin-mocha";
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
