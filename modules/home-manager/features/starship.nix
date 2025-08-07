{
  config,
  lib,
  ...
}:
let
  feature = "starship";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.starship = {
      enable = true;
      settings.character = {
        success_symbol = "[%](bold green) ";
        error_symbol = "[%](bold red) ";
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
