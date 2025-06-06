{ lib, userName, ... }:
{
  imports =
    let
      featuresDir = ../features;
    in
    map (name: featuresDir + "/${name}") (builtins.attrNames (builtins.readDir featuresDir));

  flaresolverr.enable = lib.mkDefault true;
  jellyfin.enable = lib.mkDefault true;
  prowlarr.enable = lib.mkDefault true;
  radarr.enable = lib.mkDefault true;
  sonarr.enable = lib.mkDefault true;
  transmission.enable = lib.mkDefault true;

  users.groups.media = { };
  users.users.${userName}.extraGroups = [ "media" ];
}
