{
  config,
  lib,
  pkgs,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "gaming";
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
    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
      lutris
      heroic
      wine
      wine64
      winetricks
    ];

    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
