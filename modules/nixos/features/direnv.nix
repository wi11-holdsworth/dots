{
  config,
  lib,
  ...
}:
let
  feature = "direnv";
in
{
  config = lib.mkIf config.${feature}.enable { programs.${feature}.enable = true; };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
