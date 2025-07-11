{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "amd-gpu";
in
{
  config = lib.mkIf config.${feature}.enable {

    # load graphics drivers before anything else
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
    };

    services.xserver.videoDrivers = [ "amdgpu" ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
