{
  config,
  lib,
  pkgs,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "print-and-scan";
  dependencies = with config; [
    amd-desktop
    core
  ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.hplip ];
    };
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing = {
        enable = true;
        drivers = [ pkgs.hplip ];
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
