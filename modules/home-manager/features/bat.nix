{
  config,
  pkgs,
  lib,
  ...
}:
let
  feature = "bat";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
