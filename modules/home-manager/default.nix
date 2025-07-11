{ lib, ... }:
let
  featureBundler =
    featuresDir:
    map (name: featuresDir + "/${name}") (builtins.attrNames (builtins.readDir featuresDir));
in
{
  imports = (featureBundler ./bundles) ++ (featureBundler ./features);

  bash.enable = lib.mkDefault true;
  gh.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  zoxide.enable = lib.mkDefault true;
}
