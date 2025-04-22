{ config, lib, pkgs, ... }:
let
  # declare the module name and its local module dependencies
  feature = "intel-desktop";
  dependencies = with config; [ core jellyfin ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
    environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

    hardware = {
      enableAllFirmware = true;
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          libva-vdpau-driver
          intel-compute-runtime
          vpl-gpu-rt
          intel-ocl
        ];
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
