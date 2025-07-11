{ config, lib, ... }:
let
  feature = "bash";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.bash.enable = true;
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
