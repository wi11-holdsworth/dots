{
  config,
  lib,
  userName,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "web-services";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    couchdb.enable = true;
    dufs.enable = true;
    homepage-dashboard.enable = true;
    immich.enable = true;
    jellyfin-bundle.enable = true;
    miniflux.enable = true;
    ntfy-sh.enable = true;
    stirling-pdf.enable = true;
    vaultwarden.enable = true;
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
