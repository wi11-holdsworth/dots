{
  config,
  lib,
  nixosConfig,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "zoxide";
  homeManagerDependencies = with config; [ ];
  nixosDependencies = with nixosConfig; [ core ];

  # helper functions
  homeManagerDependenciesEnabled = (lib.all (dep: dep.enable) homeManagerDependencies);
  nixosDependenciesEnabled = (lib.all (dep: dep.enable) nixosDependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && nixosDependenciesEnabled && homeManagerDependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd j"
      ];
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
