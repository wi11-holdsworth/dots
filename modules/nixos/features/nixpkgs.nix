{ config, lib, ... }:
let
  feature = "nixpkgs";
in
{
  config = lib.mkIf config.${feature}.enable {
    nixpkgs.config.allowUnfree = true;
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
