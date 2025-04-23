{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "speakers";
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
    boot.extraModprobeConfig = ''
      options snd_hda_intel power_save=0
    '';
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
