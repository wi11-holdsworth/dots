{ config, lib, ... }:
let
  feature = "desktop";
in
{
  config = lib.mkIf config.${feature}.enable {
    kitty.enable = true;
    obsidian.enable = true;
    zellij.enable = true;
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
