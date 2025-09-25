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
      extraConfig.general.unsafe-accounts-conf = true;
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
