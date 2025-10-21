{
  pkgs,
  ...
}:
{
  # load graphics drivers before anything else
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
