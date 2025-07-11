{
  config,
  lib,
  hostName,
  ...
}:
let
  feature = "network";
in
{
  config = lib.mkIf config.${feature}.enable {
    networking.hostName = "${hostName}";
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
