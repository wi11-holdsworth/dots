{ lib, ... }:
let
  featureBundler =
    featuresDir:
    map (name: featuresDir + "/${name}") (builtins.attrNames (builtins.readDir featuresDir));
in
{
  imports = (featureBundler ./features) ++ (featureBundler ./bundles);

  agenix.enable = lib.mkDefault true;
  cli-utils.enable = lib.mkDefault true;
  core.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  home-manager.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}
