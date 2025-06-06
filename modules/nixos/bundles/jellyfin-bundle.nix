{
  config,
  lib,
  userName,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "jellyfin-bundle";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    flaresolverr.enable = true;
    jellyfin.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    transmission.enable = true;

    users.groups.media = { };
    users.users.${userName}.extraGroups = [ "media" ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
