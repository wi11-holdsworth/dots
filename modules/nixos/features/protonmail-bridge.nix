{
  config,
  lib,
  ...
}:
let
  feature = "protonmail-bridge";
in
{
  config = lib.mkIf config.${feature}.enable {
    services.protonmail-bridge.enable = true;
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
