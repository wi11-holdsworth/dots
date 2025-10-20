{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "fonts";
in
{
  config = lib.mkIf config.${feature}.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter-nerdfont
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
