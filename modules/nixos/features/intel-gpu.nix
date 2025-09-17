{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "intel-gpu";
in
{
  config = lib.mkIf config.${feature}.enable {
    hardware = {
      enableAllFirmware = true;
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          # keep-sorted start 
          intel-compute-runtime
          intel-media-driver
          intel-ocl
          libva-vdpau-driver
          vpl-gpu-rt
          # keep-sorted end 
        ];
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
