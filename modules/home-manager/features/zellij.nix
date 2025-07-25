{
  config,
  lib,
  ...
}:
let
  feature = "zellij";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.zellij = {
      enable = true;
      settings = {
        theme = "catppuccin-mocha";
        show_startup_tips = false;
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
