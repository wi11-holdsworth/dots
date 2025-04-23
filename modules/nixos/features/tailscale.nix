{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "tailscale";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    services = {
      ${feature}.enable = true;
      nginx.tailscaleAuth.enable = true;
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
