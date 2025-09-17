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
          intel-media-driver
          libva-vdpau-driver
          intel-compute-runtime
          vpl-gpu-rt
          intel-ocl
          # keep-sorted end 
        ];
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
