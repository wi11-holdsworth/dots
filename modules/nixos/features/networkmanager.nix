{
  config,
  lib,
  hostName,
  ...
}:
let
  feature = "networkmanager";
in
{
  config = lib.mkIf config.${feature}.enable {
    networking = {
      hostName = "${hostName}";
      networkmanager.enable = true;
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
