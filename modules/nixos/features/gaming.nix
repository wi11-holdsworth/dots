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
      heroic
      lutris
      mangohud
      nexusmods-app
      protonup-qt
      wine
      wine64
      winetricks
      prismlauncher
    ];

    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };

    # latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
