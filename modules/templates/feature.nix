{ config, lib, ... }:
let
  feature = "replace";
in
{
  config = lib.mkIf config.${feature}.enable {

  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
