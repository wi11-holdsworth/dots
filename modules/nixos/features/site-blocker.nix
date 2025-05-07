{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "site-blocker";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

  makeEntry = site: ''
    127.0.0.1 ${site} www.${site} 
    ::1 ${site} www.${site}'';

  blockDomains = domains: lib.concatMapStringsSep "\n" makeEntry domains;
in
{
  config = lib.mkIf enabled {
    networking.extraHosts = blockDomains [
      "reddit.com"
      "youtube.com"
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
