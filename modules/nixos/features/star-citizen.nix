{
  # keep-sorted start
  inputs,
  system,
  # keep-sorted end
  ...
}:
{
  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
  };

  environment.systemPackages = [
    inputs.nix-citizen.packages.${system}.rsi-launcher
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    writebackDevice = "/dev/sda1";
  };
}
