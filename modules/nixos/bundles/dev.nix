{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "dev";
in
{
  config = lib.mkIf config.${feature}.enable {
    environment.systemPackages = with pkgs; [
      swi-prolog
      vscode
      devenv
    ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
