{ lib, ... }: {
  imports = let featuresDir = ./features;
  in map (name: featuresDir + "/${name}")
  (builtins.attrNames (builtins.readDir featuresDir));

  git.enable = lib.mkDefault true;
  bash.enable = lib.mkDefault true;
}
