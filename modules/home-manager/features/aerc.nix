{
  config,
  lib,
  ...
}:
let
  feature = "aerc";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.aerc = {
      enable = true;
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
