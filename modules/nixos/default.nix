{ lib, ... }: {
  imports = let featuresDir = ./features;
  in map (name: featuresDir + "/${name}")
  (builtins.attrNames (builtins.readDir featuresDir));

  core.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  home-manager.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}
