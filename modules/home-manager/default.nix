{ lib, ... }:
{
  imports =
    let
      featuresDir = ./features;
    in
    map (name: featuresDir + "/${name}") (builtins.attrNames (builtins.readDir featuresDir));

  alacritty.enable = lib.mkDefault true;
  bash.enable = lib.mkDefault true;
  gh.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  zoxide.enable = lib.mkDefault true;
}
