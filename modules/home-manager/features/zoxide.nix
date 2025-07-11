{
  config,
  lib,
  ...
}:
let
  feature = "zoxide";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd j"
      ];
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
