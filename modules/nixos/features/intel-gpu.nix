{
  pkgs,
  ...
}:
{
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
}
