{
  config,
  lib,
  ...
}:
let
  feature = "espanso";
in
{
  config = lib.mkIf config.${feature}.enable {
    services.espanso = {
      enable = true;
      configs = { };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
